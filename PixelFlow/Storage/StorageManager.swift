//
//  StorageManager.swift
//  PixelFlow
//
//  Created by Елизавета on 23.05.2021.
//

import Foundation

class StorageManager {
    var storageManagerDelegate: StorageManagerDelegate = DataStoreManager()

    func saveDay(day: Day) {
        storageManagerDelegate.updateDay(day)
    }

    func getBoards() -> [Board] {
        storageManagerDelegate.getBoards()
    }

}
