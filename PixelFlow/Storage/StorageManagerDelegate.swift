//
//  StorageManagerDelegate.swift
//  PixelFlow
//
//  Created by Елизавета on 23.05.2021.
//

import Foundation

protocol StorageManagerDelegate {
    func saveDay(_ dayToSave: Day)
    func getBoards() -> [Board]
}
