//
//  DateExtension.swift
//  HelloSwiftKits
//
//  Created by James on 2019/7/28.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import Foundation
public let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatter.doesRelativeDateFormatting = true
    formatter.formattingContext = .standalone
    return formatter
}()

public extension Date {
    
    func judgeSomeMinute(date: Date) -> Bool {
        return judge(format: "yyyyMMyyhhmm", date: date)
    }
    
    func judgeSomeHour(date: Date) -> Bool {
        return judge(format: "yyyyMMyyhh", date: date)
    }
    
    func judgeSomeDay(date: Date ) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: self)
    }
    
    func judgeSomeWeek(date: Date) -> Bool {
        return self.year == date.year && self.weekForYear == date.weekForYear
    }
    
    func judgeSomeMonth(date: Date) -> Bool {
        return judge(format: "yyMM", date: date)
    }
    
    func judgeSomeYear(date: Date) -> Bool {
        return self.year == date.year
    }
    
    fileprivate func judge(format: String, date: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self) == formatter.string(from: date)
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    var isWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }
}

extension Date {
    
    public mutating func add(_ component: Calendar.Component, value: Int) {
        self = Calendar.current.date(byAdding: component, value: value, to: self) ?? Date(timeIntervalSince1970: 0)
    }
}

public extension Date {
    var minute: Int {
        set {
            let date = Calendar.current.date(bySetting: .minute, value: newValue, of: self)
            if let date = date {
                self = date
            }
        }
        get {
            return Calendar.current.component(.minute, from: self)
        }
    }
    
    var hour: Int {
        set {
            let date = Calendar.current.date(bySetting: .hour, value: newValue, of: self)
            if let date = date {
                self = date
            }
        }
        get {
            return Calendar.current.component(.hour, from: self)
        }
    }
    
    var day: Int {
        set {
            let date = Calendar.current.date(bySetting: .day, value: newValue, of: self)
            if let date = date {
                self = date
            }
        }
        get {
            return Calendar.current.component(.day, from: self)
        }
    }
    
    var weekDay: Int {
        set {
            let date = Calendar.current.date(bySetting: .weekday, value: newValue, of: self)
            if let date = date {
                self = date
            }
        }
        get {
            return Calendar.current.component(.weekday, from: self)
        }
    }
    
    /// Week In The Month
    var week: Int {
        set {
            let date = Calendar.current.date(bySetting: .weekOfMonth, value: newValue, of: self)
            if let date = date {
                self = date
            }
        }
        get {
            return Calendar.current.component(.weekday, from: self)
        }
    }
    
    /// Week In The Year
    var weekForYear: Int {
        set {
            let date = Calendar.current.date(bySetting: .weekOfYear, value: newValue, of: self)
            if let date = date {
                self = date
            }
        }
        get {
            return Calendar.current.component(.weekOfYear, from: self)
        }
    }
    
    var month: Int {
        set {
            let date = Calendar.current.date(bySetting: .month, value: newValue, of: self)
            if let date = date {
                self = date
            }
        }
        get {
            return Calendar.current.component(.month, from: self)
        }
    }
    
    var year: Int {
        set {
            let date = Calendar.current.date(bySetting: .year, value: newValue, of: self)
            if let date = date {
                self = date
            }
        }
        get {
            return Calendar.current.component(.year, from: self)
        }
    }
    
    /// The first day of the month
    var dayForMonth: Date {
        get {
            guard var date = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self) else { fatalError("date Calendar Error") }
            date.add(.day, value: -date.day)
            return date
        }
    }
    
    /// The first day of the Week
    var dayForWeek: Date {
        get {
            guard var date = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date()) else { fatalError("date Calendar Error") }
            date.add(.day, value: -date.weekDay)
            return date
        }
    }
}

extension Date {
    var dateWeekZh: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            formatter.locale = Locale(identifier: "zh_CN")
            return formatter.string(from: self)
        }
    }
    
    var dateWeek: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            return formatter.string(from: self)
        }
    }
    
    var monthDayNum: Int {
        let calendar = NSCalendar.current
        guard let rang = calendar.range(of: .day, in: .month, for: self) else { fatalError("calendar.range(of: .day, in: .month, for: self Error)")  }
        return rang.count
    }
    
    var yearNum: Int {
        let calendar = NSCalendar.current
        guard let rang = calendar.range(of: .day, in: .year, for: self) else { fatalError("calendar.range(of: .day, in: .year, for: self Error)")  }
        return rang.count
    }
}
