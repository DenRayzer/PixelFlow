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
    func saveBoard(board: Board)
    func updateBoard(boardToUpdate: Board)
    func deleteBoard(boardName: String) -> Bool
    func getBoardByName(boardName: String) -> Board?
}
