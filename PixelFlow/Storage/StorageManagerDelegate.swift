//
//  StorageManagerDelegate.swift
//  PixelFlow
//
//  Created by Елизавета on 23.05.2021.
//

import Foundation

protocol StorageManagerDelegate {
    func updateDay(_ dayToSave: Day)
    func getBoards() -> [Board]
//    func saveBoard(board: Board)
//    func updateBoard(board: Board)
//    func deleteBoard(board: Board)
}
