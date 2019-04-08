//
//  SingleCalender.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/5.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class SingleCalender: NSObject {
    
    static let shared = SingleCalender()
    fileprivate lazy var calendar: NSCalendar = {
        var calendar = NSCalendar.current as NSCalendar
        calendar.locale = Locale(identifier: "zh_CN")
        return calendar
    }()
    
    private override init() { }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension SingleCalender {
    
    func day(from date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    func month(from date: Date) -> Int {
        return calendar.component(.month, from: date)
    }
    
    func year(from date: Date) -> Int {
        return calendar.component(.year, from: date)
    }
    
}


extension SingleCalender {
    
    func firstWeekdayInThisMonth(_ date: Date) -> Int {
        calendar.firstWeekday = 1
        
        var components = calendar.components([.year, .month, .day], from: date)
        components.day = 1
        let firstDayOfMonth = calendar.date(from: components)!
        let firstWeekday = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: firstDayOfMonth)
        return firstWeekday-1
    }
    
    func totalDaysInThisMonth(_ date: Date) -> Int {
        let totalDaysInMonth = SingleCalender.shared.calendar.range(of: .day, in: .month, for: date)
        return totalDaysInMonth.length
    }
    
//    func firstDateInThisMonth(_ date: Date) -> Date {
//        <#function body#>
//    }
//    
//    func lastDays(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
}


extension SingleCalender {
    
    func lastMonth(_ date: Date) -> Date {
        return month(date, offset: -1)
    }
    
    func nextMonth(_ date: Date) -> Date {
        return month(date, offset: +1)
    }
    
    private func month(_ date: Date, offset: Int) -> Date {
        var components = DateComponents()
        components.month = offset
        let newDate = calendar.date(byAdding: components, to: date, options: [])
        return newDate!
    }
}


extension SingleCalender {
    
    func isDate(_ date: Date, inThisMonth another: Date ) -> Bool {
        let components1 = calendar.components([.year, .month], from: date)
        let components2 = calendar.components([.year, .month], from: another)
        return components1.year! == components2.year! && components1.month == components2.month
    }
    
    func isDate(_ date: Date, equalTo another: Date) -> Bool {
        let components1 = calendar.components([.year, .month], from: date)
        let components2 = calendar.components([.year, .month], from: another)
        return components1.year! == components2.year! && components1.month == components2.month && components1.day! == components2.day
    }
    
}
