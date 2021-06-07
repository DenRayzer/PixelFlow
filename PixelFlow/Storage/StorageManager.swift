//
//  StorageManager.swift
//  PixelFlow
//
//  Created by Елизавета on 23.05.2021.
//

import Foundation

class StorageManager {
    var storageManagerDelegate: StorageManagerDelegate = CoreDataDataStoreManager()

    func saveDay(day: Day) {
        storageManagerDelegate.updateDay(day)
    }

    func getBoards() -> [Board] {
        storageManagerDelegate.getBoards()
    }

    func saveBoard(board: Board) {
        storageManagerDelegate.saveBoard(board: board)
    }

    func deleteBoard(boardName: String) -> Bool {
        storageManagerDelegate.deleteBoard(boardName: boardName)
    }
}
