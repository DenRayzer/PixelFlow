//
//  PixelSheetPresenter.swift
//  PixelFlow
//
//  Created by Елизавета on 20.05.2021.
//

import Foundation

class PixelSheetPresenter: PixelSheetPresenterDelegate {
    var board: Board
    var years: [Year]
    let storageManager = StorageManager()

    init() {
        if ThemeHelper.currentBoard == nil {
            ThemeHelper.currentBoard = storageManager.getBoard(boardName: StorageManager.getMainBoardName())
            measure("ХЫХЫХЫХ") { finish in
                ThemeHelper.currentBoard?.years.forEach { $0.configureMonths() }
                finish()
            }
        }


        self.board = ThemeHelper.currentBoard!
        print("board name \(board.name)")
        self.years = board.years
        self.years.sort { $0.year > $1.year }
        ThemeHelper.currentBoard = board
    }

}
