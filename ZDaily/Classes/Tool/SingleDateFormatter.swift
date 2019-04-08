//
//  SingleDateFormatter.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/4.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class SingleDateFormatter: DateFormatter {
    
    static let shared = SingleDateFormatter()
    
    private override init() { super.init() }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SingleDateFormatter {
    
    func formattedDate(_ date: TimeInterval, dateFormat: String) -> String {
        let formatter = SingleDateFormatter.shared
        formatter.dateFormat = dateFormat
        return formatter.string(from: Date(timeIntervalSince1970: date))
    }
    
    func zdailyDateString(_ date: Date) -> String {
        let formatter = SingleDateFormatter.shared
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: date)
    }
    
    func zdailyCalendarMonthYear(_ date: Date) -> String {
        let formatter = SingleDateFormatter.shared
        formatter.dateFormat = "MM月 yyyy"
        return formatter.string(from: date)
    }
    
    func humanFormattedDate(_ date: TimeInterval) -> String {
        /// < 60s, 刚刚
        /// >= 1min && < 1h, xx分钟前
        /// >= 1h && < 1d, xx小时前
        /// >= 1d && < 4d, xx天前
        /// >= 4d, yyyy年M月d日
        
        let now = Date().timeIntervalSince1970
        let offset = Int(now-date)/1000
        if offset < 60 {
            return "刚刚"
        } else if offset < 3600 {
            return "\(offset/60)分钟前"
        } else if offset < 86400 {
            return "\(offset/3600)小时前"
        } else if offset < 345600 {
            return "\(offset/86400)小时前"
        } else {
            return SingleDateFormatter.shared.formattedDate(date, dateFormat: "yyyy年M月d日")
        }
    }
}
