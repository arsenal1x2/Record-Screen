//
//  Date+Extension.swift
//  RecordScreen
//
//  Created by LTT on 12/17/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import Foundation

extension Date {
    var day: Int {
        return Calendar(identifier: .gregorian).component(.day, from: self)
    }

    var weekDay: Int {
        /*
         1: Sun
         2: Mon
         3: Tue
         4: Wed
         5: Thu
         6: Fri
         7: Sat
         */
        return Calendar(identifier: .gregorian).component(.weekday, from: self)
    }

    var yesterday: Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: 1, to: self)!
    }
    var noon: Date {
        return Calendar(identifier: .gregorian).date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    var lastMonthDate: Date {
        return Calendar(identifier: .gregorian).date(byAdding: .month, value: -1, to: self)!
    }

    var lastMonth: Int {
        return Calendar(identifier: .gregorian).component(.month, from: lastMonthDate)
    }

    var nextMonthDate: Date {
        return Calendar(identifier: .gregorian).date(byAdding: .month, value: 1, to: self)!
    }

    var nextMonth: Int {
        return Calendar(identifier: .gregorian).component(.month, from: nextMonthDate)
    }
    var month: Int {
        return Calendar(identifier: .gregorian).component(.month, from: self)
    }
    var lastYear: Int {
        let lastYearDate = Calendar(identifier: .gregorian).date(byAdding: .year, value: -1, to: self)!
        return Calendar(identifier: .gregorian).component(.year, from: lastYearDate)
    }
    var nextYear: Int {
        let nextYearDate = Calendar(identifier: .gregorian).date(byAdding: .year, value: 1, to: self)!
        return Calendar(identifier: .gregorian).component(.year, from: nextYearDate)
    }
    var year: Int {
        return Calendar(identifier: .gregorian).component(.year, from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }

    var toDateStringYMD: String {
        let dateFormatter = DateFormatter(dateFormat: "y/M/d")
        return dateFormatter.string(from: self)
    }

    func getDayOfWeek() -> Int {
        /*
         1: Sun
         2: Mon
         3: Tue
         4: Wed
         5: Thu
         6: Fri
         7: Sat
         */
        let calendar = Calendar(identifier: .gregorian)
        let dayOfWeek = calendar.component(.weekday, from: self)
        return dayOfWeek
    }

    func getTitleDayOfWeek() -> String {
        let weekDaysDefault = ["日", "月", "火", "水", "木", "金", "土"]
        return weekDaysDefault[getDayOfWeek() - 1]
    }
}
