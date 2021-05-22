//
//  DataStoreManager.swift
//  PixelFlow
//
//  Created by Елизавета on 16.05.2021.
//

import Foundation
import CoreData

class DataStoreManager {
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
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func obtainBoards() {

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

    func fetchBoars() -> [BoardMO]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")

        do {
            if let mm = try viewContext.fetch(fetchRequest) as? [BoardMO] {
                print("mmmmmmm -------- \(mm)")
                return mm }

        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BoardMO")
//     //   fetchRequest.predicate = NSPredicate(format: "ALL")
//        if let boards = try? viewContext.fetch(fetchRequest) as? [BoardMO], !boards.isEmpty {
//            print("kgofkgrogkeogkr")
//            print(boards)
//        } else {
//            print("хуй")
//        }
    }

    func intitBoard() {
        var years: [YearMO] = []
        var parameters: [BoardParameterMO] = []
        let components = Calendar.current.dateComponents([.year], from: Date())

        for i in 0...5 {
            print("vfdvfd  \(components)")
            let year = YearMO(context: viewContext)

            year.save(yearInt: (components.year ?? 99) + i)
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

    }

}

