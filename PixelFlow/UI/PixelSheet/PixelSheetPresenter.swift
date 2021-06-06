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
//        if true {
//            self.board = Board(name: "Board", imageName: "yin-yang-cyan", mainColorId: 0, years: [Year(year: 2021, days: [])], colorShemeId: 0, parameters: [BoardParameter(name: "PAr1", color: 1, colorSheme: 0)], notifications: [NotificationSetting(time: Date(), isOn: true)])
//        } else {
//            self.board = storageManager.getBoards().last!
//        }

        if ThemeHelper.currentBoard == nil {
            ThemeHelper.currentBoard = storageManager.getBoards().last!
        }

        self.board = ThemeHelper.currentBoard!

        self.years = board.years
        self.years.sort { $0.year > $1.year }
        ThemeHelper.currentBoard = board
    }

//    private func getBoardInfo() -> Board {
//        return Board(name: "Board1", imageName: StringConstants.defaultBoardImageName, mainColorName: StringConstants.defaultBoardColorName,
//            years: [Year(year: 2021)],
//            colorSheme: .base,
//            parameters: [BoardParameter(name: "Good", color: StringConstants.defaultBoardColorName)],
//            notifications: [NotificationSetting(time: "20:00", isOn: true)])
//    }
}
