//
//  Note.swift
//  PixelFlow
//
//  Created by Елизавета on 22.05.2021.
//

import Foundation

class Note {
    var text: String
    var date: Date

    internal init(text: String, date: Date) {
        self.text = text
        self.date = date
    }
}
