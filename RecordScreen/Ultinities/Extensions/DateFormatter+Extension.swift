//
//  DateFormatter+Extension.swift
//  RecordScreen
//
//  Created by LTT on 12/17/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.calendar = Calendar(identifier: .gregorian)
        self.dateFormat = dateFormat
    }
}
