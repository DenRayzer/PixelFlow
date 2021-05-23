//
//  BoardParameter.swift
//  PixelFlow
//
//  Created by Елизавета on 15.05.2021.
//

import Foundation

class BoardParameter {
    var name: String
    var color: Int16

    internal init(name: String, color: Int16) {
        self.name = name
        self.color = color
    }
}
