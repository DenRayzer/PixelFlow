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
    let storageManager = StorageManager()

    init() {
        if !true {
        self.boardInfo = Board(name: "Board", imageId: 0, mainColorId: 0, years: [Year(year: 2021, days: [])], colorShemeId: 0, parameters: [BoardParameter(name: "PAr1", color: 0)], notifications: [NotificationSetting(time: Date(), isOn: true)])
        } else {
            self.boardInfo = storageManager.getBoards().last!
        } //       Board(name: "Board1",
//            imageName: StringConstants.defaultBoardImageName,
//            mainColorName: StringConstants.defaultBoardColorName,
//            years: [Year(year: 2021)],
//            colorSheme: .base,
//            parameters: [BoardParameter(name: "Good", color: StringConstants.defaultBoardColorName)],
//            notifications: [NotificationSetting(time: "20:00", isOn: true)])
            //storageManager.getBoards().last!
        self.years = boardInfo.years
        self.years.sort { $0.year > $1.year}

    }

//    private func getBoardInfo() -> Board {
//        return Board(name: "Board1", imageName: StringConstants.defaultBoardImageName, mainColorName: StringConstants.defaultBoardColorName,
//            years: [Year(year: 2021)],
//            colorSheme: .base,
//            parameters: [BoardParameter(name: "Good", color: StringConstants.defaultBoardColorName)],
//            notifications: [NotificationSetting(time: "20:00", isOn: true)])
//    }
}
