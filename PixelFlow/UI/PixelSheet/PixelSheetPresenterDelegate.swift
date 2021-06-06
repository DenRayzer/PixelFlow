//
//  PixelSheetPresenterDelegate.swift
//  PixelFlow
//
//  Created by Елизавета on 22.05.2021.
//

import Foundation

protocol PixelSheetPresenterDelegate {
    var board: Board { get }
    var years: [Year] { get set }
}
