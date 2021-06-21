//
//  StorageManager.swift
//  PixelFlow
//
//  Created by Елизавета on 23.05.2021.
//

import Foundation

class StorageManager {
    static let mainBoardKey = "MainBoardKey"
    var storageManagerDelegate: StorageManagerDelegate = CoreDataDataStoreManager()

    func saveDay(day: Day) {
        storageManagerDelegate.updateDay(day)
    }

    func getBoards() -> [Board] {
        storageManagerDelegate.getBoards()
    }

    func getBoard(boardName: String) -> Board? {
        storageManagerDelegate.getBoardByName(boardName: boardName)
    }

    func saveBoard(board: Board) {
        storageManagerDelegate.saveBoard(board: board)
    }

    func updateBoard(board: Board) {
        storageManagerDelegate.updateBoard(boardToUpdate: board)
    }

    func deleteBoard(boardName: String) -> Bool {
        storageManagerDelegate.deleteBoard(boardName: boardName)
    }

   static func getMainBoardName() -> String {
    return UserDefaults.standard.string(forKey: mainBoardKey) ?? ""
    }

   static func setMainBoardName(name: String) {
        UserDefaults.standard.setValue(name, forKey: mainBoardKey)
    }
}
