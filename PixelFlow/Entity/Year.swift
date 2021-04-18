//
//  Year.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/18/21.
//

import Foundation

struct Year {
    let year: Int
    var months: [[Day?]] = Array(repeating: Array(repeating: nil, count: 31), count: 12)
}
