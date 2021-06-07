//
//  DataStoreManager.swift
//  PixelFlow
//
//  Created by Елизавета on 16.05.2021.
//

import Foundation
import CoreData

class CoreDataDataStoreManager: StorageManagerDelegate {
    func updateBoard(board: Board) {

    }

    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PixelFlowDB")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }

        }
        return container
    }()

    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func updateDay(_ dayToSave: Day) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Board")
        fetchRequest.predicate = NSPredicate(format: "name == %@", ThemeHelper.currentBoard?.name ?? "")
        if let board = try? viewContext.fetch(fetchRequest) as? [BoardMO] {

            guard let _ = board.first else {

                return
            }
            let newDay = makeDayMO(from: dayToSave)
            board.first?.years.forEach { year in
                guard let year = year as? YearMO else { return }
                if year.year == dayToSave.date.get(.year) {
                    var flag = true
                    year.days?.forEach { day in
                        guard let day = day as? DayMO else { return }
                        if day.date == dayToSave.date {
                            flag = false
                            day.colorId = dayToSave.type.rawValue
                            var additionalColors: [AdditionalColorMO] = []
                            dayToSave.additionalColors.forEach { additionalColor in
                                let color = AdditionalColorMO(context: viewContext)
                                color.colorId = additionalColor.colorType.rawValue
                                color.time = additionalColor.date
                                additionalColors.append(color)
                            }

                            var notes: [NoteMO] = []
                            dayToSave.notes.forEach { note in
                                let noteMO = NoteMO(context: viewContext)
                                noteMO.note = note.text
                                noteMO.time = note.date
                                notes.append(noteMO)
                            }
                            day.addToAdditionalColor(NSOrderedSet(array: additionalColors))
                            day.addToNote(NSOrderedSet(array: notes))
                            return
                        }
                    }
                    if flag {
                        let dayMO = makeDayMO(from: dayToSave)
                        year.addToDays(dayMO)
                    }
                    return
                }
            }
            try? viewContext.save()
        }
    }

    private func saveDayForYear(year: Int, dayToSave: Day) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Year")
        fetchRequest.predicate = NSPredicate(format: "year == \(year)")

        do {
            if let years = try viewContext.fetch(fetchRequest) as? [YearMO] {
                guard let year = years.first else { return }
                let day = makeDayMO(from: dayToSave)
                year.addToDays(day)

                try? viewContext.save()
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    private func makeDayMO(from dayToSave: Day) -> DayMO {
        let day = DayMO(context: viewContext)
        day.date = dayToSave.date
        day.colorId = dayToSave.type.rawValue

        var additionalColors: [AdditionalColorMO] = []
        dayToSave.additionalColors.forEach { additionalColor in
            let color = AdditionalColorMO(context: viewContext)
            color.colorId = additionalColor.colorType.rawValue
            color.time = additionalColor.date
            additionalColors.append(color)
        }

        var notes: [NoteMO] = []
        dayToSave.notes.forEach { note in
            let noteMO = NoteMO(context: viewContext)
            noteMO.note = note.text
            noteMO.time = note.date
            notes.append(noteMO)
        }

        day.addToAdditionalColor(NSOrderedSet(array: additionalColors))
        day.addToNote(NSOrderedSet(array: notes))

        return day
    }

    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Board")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch let error {
            print ("There was an error \(error.localizedDescription)")
        }
    }
    func deletedays() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Day")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch let error {
            print ("There was an error \(error.localizedDescription)")
        }
    }

    func getBoards() -> [Board] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")

        do {
            if let boards = try viewContext.fetch(fetchRequest) as? [BoardMO] {
                if boards.count > 0 {
                    print("ZASHLO SYDA ---------")
                    return convertBoardsMO(boardsMO: boards)
                } else {
                    return convertBoardsMO(boardsMO: [intitBoard()])
                }
            }

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return []
    }

    func fetchDays() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Day")

        do {
            if let boards = try viewContext.fetch(fetchRequest) as? [DayMO] {
                boards.forEach { day in
                    print("DAYS DAYS ---- \(day.date)  ----  \(day.colorId)")

                }
            }

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }

    func fetchYears() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Year")

        do {
            if let boards = try viewContext.fetch(fetchRequest) as? [YearMO] {
                boards.forEach { day in
                    print("DAYS DAYS ---- \(day.year)")

                }
            }

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }

    func intitBoard() -> BoardMO {
        var parameters: [BoardParameterMO] = []

        for i in 1...7 {
            parameters.append(getDayInfo(for: i))
        }

        let board = BoardMO(context: viewContext)
        board.save(notifications: NSSet(object: NotificationMO(context: viewContext)), parameters: NSSet(array: parameters), years: createBaseYears())
        do {
            try viewContext.save()
        } catch let error {
            print("save board error \(error.localizedDescription)")
        }
        return board
    }

    func getDayInfo(for id: Int) -> BoardParameterMO {
        let type = DayType(rawValue: Int16(id)) ?? DayType.null
        let parametr = BoardParameterMO(context: viewContext)
        parametr.colorId = Int16(id)
        parametr.inOrder = Int16(id)

        switch type {
        case .null:
            parametr.name = "Не выбрано"
            return parametr
        case .first:
            parametr.name = "pf_day_mood_excellent".localize()
            return parametr
        case .second:
            parametr.name = "pf_day_mood_good".localize()
            return parametr
        case .third:
            parametr.name = "pf_day_mood_lazy".localize()
            return parametr
        case .fourth:
            parametr.name = "pf_day_mood_ordinary".localize()
            return parametr
        case .fifth:
            parametr.name = "pf_day_mood_bad".localize()
            return parametr
        case .sixth:
            parametr.name = "pf_day_mood_tired".localize()
            return parametr
        case .seventh:
            parametr.name = "pf_day_mood_sick".localize()
            return parametr
        case .eighth:
            parametr.name = "Не выбрано"
            return parametr
        }
    }

    private func createBaseYears() {

    }

}

// MARK: - convert models methods
extension CoreDataDataStoreManager {
    private func convertBoardsMO(boardsMO: [BoardMO]) -> [Board] {
        var boards: [Board] = []

        boardsMO.forEach { boardMO in
            let parameters: [BoardParameter] = convertBoardParameters(parametersSet: boardMO.parameters, colorSheme: boardMO.colorSheme)
            let board = Board(name: boardMO.name,
                imageName: boardMO.imageName,
                mainColorId: boardMO.mainColorId,
               years: convertYearsMO(yearsSet: boardMO.years),
                colorShemeId: boardMO.colorSheme,
                parameters: parameters,
                notifications: convertNotificationsMO(notificationsSet: boardMO.notifications))
            boards.append(board)
        }

        print("A Typer ZASHLO SYDA ---------")
        return boards
    }

    private func convertYearsMO(yearsSet: NSOrderedSet) -> [Year] {
        guard let yearMO = yearsSet.array as? [YearMO] else { return [] }
        var years: [Year] = []

        print("ggg1 \(Date())")

        yearMO.forEach { mo in
            let year = Year(year: mo.year, days: convertDays(daysSet: mo.days ?? NSOrderedSet()))
            years.append(year)
          //  i += 1
        }

        print("ggg2 \(Date())")

        return years
    }

    private func convertDays(daysSet: NSOrderedSet) -> [Day] {
        guard let daysMO = daysSet.array as? [DayMO] else { return [] }
        var days: [Day] = []
        daysMO.forEach { dayMO in
            let day = Day(date: dayMO.date,
                typeId: dayMO.colorId,
                notes: convertNotes(notesSet: dayMO.note ?? NSOrderedSet()),
                additionalColors: convertAdditionalColors(colorsSet: dayMO.additionalColor ?? NSOrderedSet()))
            days.append(day)

        }
        return days
    }

    private func convertBoardParameters(parametersSet: NSOrderedSet, colorSheme: Int16) -> [BoardParameter] {
        guard var parametersMO = parametersSet.array as? [BoardParameterMO] else { return [] }
        parametersMO.sort(by: { $0.inOrder < $1.inOrder })
        var parameters: [BoardParameter] = []
        parametersMO.forEach { parameterMO in
            let parameter = BoardParameter(name: parameterMO.name,
                color: parameterMO.colorId, colorSheme: colorSheme)
            parameters.append(parameter)
        }
        return parameters
    }


    private func convertNotificationsMO(notificationsSet: NSOrderedSet) -> [NotificationSetting] {
        guard let notificationMO = notificationsSet.array as? [NotificationMO] else { return [] }
        var notifications: [NotificationSetting] = []
        notificationMO.forEach { notificationMO in
            let notification = NotificationSetting(time: notificationMO.time,
                isOn: notificationMO.isOn)
            notifications.append(notification)
        }
        return notifications
    }

    private func convertNotes(notesSet: NSOrderedSet) -> [Note] {
        guard let notesMO = notesSet.array as? [NoteMO] else { return [] }
        var notes: [Note] = []
        notesMO.forEach { noteMO in
            let note = Note(text: noteMO.note,
                date: noteMO.time)
            notes.append(note)
        }
        return notes
    }

    private func convertAdditionalColors(colorsSet: NSOrderedSet) -> [AdditionalColor] {
        guard let colorsMO = colorsSet.array as? [AdditionalColorMO] else { return [] }
        var colors: [AdditionalColor] = []
        colorsMO.forEach { colorMO in
            let color = AdditionalColor(colorId: colorMO.colorId,
                date: colorMO.time)
            colors.append(color)
        }
        return colors
    }

}

// MARK: --- SaveBoard
extension CoreDataDataStoreManager {

    private func createBaseYears() -> NSSet {
        var years: [YearMO] = []
        let components = Calendar.current.dateComponents([.year], from: Date())

        for i in 0...3 {
            print("vfdvfd  \(components)")
            let year = YearMO(context: viewContext)

            year.save(yearInt: (components.year ?? 99) - i)
            years.append(year)
        }

        return NSSet(array: years)
    }

    func saveBoard(board: Board) {
        let boardMO = BoardMO(context: viewContext)
        boardMO.save(name: board.name,
            imageName: board.imageName,
            notifications: convertNotificationSettings(notifications: board.notifications),
            parameters: convertParameters(parameters: board.parameters),
            years: createBaseYears())

        do {
            try viewContext.save()
        } catch let error {
            print("save board error \(error.localizedDescription)")
        }
    }

    private func convertNotificationSettings(notifications: [NotificationSetting]) -> NSSet {
        var notificationsMO: [NotificationMO] = []
        notifications.forEach { notification in
            let notificationMO = NotificationMO(context: viewContext)
            notificationMO.time = notification.time
            notificationMO.isOn = notification.isOn
            notificationsMO.append(notificationMO)
        }
        return NSSet(array: notificationsMO)
    }

    private func convertParameters(parameters: [BoardParameter]) -> NSSet {
        var parametersMO: [BoardParameterMO] = []
        parameters.forEach { parameter in
            let parameterMO = BoardParameterMO(context: viewContext)
            parameterMO.name = parameter.name
            parameterMO.colorId = parameter.color.rawValue
            parameterMO.inOrder = parameter.color.rawValue
            parametersMO.append(parameterMO)
        }
        return NSSet(array: parametersMO)
    }

}

// MARK: --- DeleteBoard
extension CoreDataDataStoreManager {
    func deleteBoard(boardName: String) -> Bool {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Board")
        fetchRequest.predicate = NSPredicate(format: "name == %@", boardName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
            return true
        } catch let error {
            print ("There was an error \(error.localizedDescription)")
            return false
        }
    }
}
