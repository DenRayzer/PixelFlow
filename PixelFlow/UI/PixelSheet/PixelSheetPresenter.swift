//
//  PixelSheetPresenter.swift
//  PixelFlow
//
//  Created by Елизавета on 20.05.2021.
//

import Foundation

class PixelSheetPresenter: PixelSheetPresenterDelegate {
    var boardInfo: Board
    var years: [Year]

    init() {
        self.boardInfo = Board(name: "Board1",
            imageName: StringConstants.defaultBoardImageName,
            mainColorName: StringConstants.defaultBoardColorName,
            years: [Year(year: 2021)],
            colorSheme: .base,
            parameters: [BoardParameter(name: "Good", color: StringConstants.defaultBoardColorName)],
            notifications: [NotificationSetting(time: "20:00", isOn: true)])
        self.years = boardInfo.years

    }

    private func getBoardInfo() -> Board {
        return Board(name: "Board1", imageName: StringConstants.defaultBoardImageName, mainColorName: StringConstants.defaultBoardColorName,
            years: [Year(year: 2021)],
            colorSheme: .base,
            parameters: [BoardParameter(name: "Good", color: StringConstants.defaultBoardColorName)],
            notifications: [NotificationSetting(time: "20:00", isOn: true)])
    }
}
