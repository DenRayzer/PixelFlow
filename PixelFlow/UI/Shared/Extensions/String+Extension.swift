//
//  String+Extension.swift
//  PixelFlow
//
//  Created by Elizaveta on 4/25/21.
//

import Foundation

extension String {
    func localize(_ table: String? = nil) -> String {
        return NSLocalizedString(self, tableName: table, bundle: Bundle.main, value: "", comment: "")
    }
}
