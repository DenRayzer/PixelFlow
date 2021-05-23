//
//  DataStoreManager.swift
//  PixelFlow
//
//  Created by Елизавета on 16.05.2021.
//

import Foundation
import CoreData

class DataStoreManager: StorageManagerDelegate {
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

    func saveDay(_ dayToSave: Day) {
        print("DATE ----  Date ---- \(dayToSave.date)")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Day")
        fetchRequest.predicate = NSPredicate(format: "date == %@", dayToSave.date as CVarArg)
            if let mm = try? viewContext.fetch(fetchRequest) as? [DayMO] {

                guard let _ = mm.first else {
                    print("vkdsijvidsvjsi ---- jisdjfisdjvsid")

                //    let dayMO = makeDayMO(from: dayToSave)
                    saveDayForYear(year: dayToSave.date.get(.year), dayToSave: dayToSave)
                    return
                }
                print("повторное ---- jisdjfisdjvsid")
                mm.first!.colorId = dayToSave.type.rawValue
                
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

                mm.first!.addToAdditionalColor(NSOrderedSet(array: additionalColors)) //.addToAdditionalColor(NSOrderedSet(array: additionalColors))
                mm.first!.addToNote(NSOrderedSet(array: notes))
               try? viewContext.save()
              //  saveContext()
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

    func fetchDays()  {
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

    func fetchYears()  {
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
        var years: [YearMO] = []
        var parameters: [BoardParameterMO] = []
        let components = Calendar.current.dateComponents([.year], from: Date())

        for i in 0...5 {
            print("vfdvfd  \(components)")
            let year = YearMO(context: viewContext)

            year.save(yearInt: (components.year ?? 99) - i)
            years.append(year)
        }

        for i in 0...5 {
            print("vfdvfd  \(components)")
            let year = BoardParameterMO(context: viewContext)
            year.name = "\(i)"
            parameters.append(year)
        }



        let board = BoardMO(context: viewContext)
        board.save(notification: NotificationMO(context: viewContext), parameters: NSSet(array: parameters), years: NSSet(array: years))
        do {
            try viewContext.save()
        } catch let error {
            print("save board error \(error.localizedDescription)")
        }
        return board
    }

}

// MARK: - convert models methods
extension DataStoreManager {
    private func convertBoardsMO(boardsMO: [BoardMO]) -> [Board] {
        var boards: [Board] = []
        boardsMO.forEach { boardMO in
            let board = Board(name: boardMO.name,
                imageId: boardMO.imageId,
                mainColorId: boardMO.mainColorId,
                years: convertYearsMO(yearsSet: boardMO.years),
                colorShemeId: boardMO.colorSheme,
                parameters: convertBoardParameters(parametersSet: boardMO.parameters),
                notifications: convertNotificationsMO(notificationsSet: boardMO.notifications))
            boards.append(board)
        }
        return boards
    }

    private func convertYearsMO(yearsSet: NSOrderedSet) -> [Year] {
        guard let yearMO = yearsSet.array as? [YearMO] else { return [] }
        var years: [Year] = []
        yearMO.forEach { mo in
            let year = Year(year: mo.year, days: convertDays(daysSet: mo.days ?? NSOrderedSet()))
            years.append(year)
        }
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

    private func convertBoardParameters(parametersSet: NSOrderedSet) -> [BoardParameter] {
        guard let parametersMO = parametersSet.array as? [BoardParameterMO] else { return [] }
        var parameters: [BoardParameter] = []
        parametersMO.forEach { parameterMO in
            let parameter = BoardParameter(name: parameterMO.name,
                color: parameterMO.colorId)
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

