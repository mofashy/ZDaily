//
//  ZalendarView+Navigator.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/6.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

extension ZalendarView {
    
    func addNavigator() {
        addSubview(lastMonthButton)
        addSubview(monthYearLabel)
        addSubview(nextMonthButton)
    }
    
    func layoutNavigator() {
        NSLayoutConstraint.activate([
            // Contraints lastMonthButton
            lastMonthButton.centerYAnchor.constraint(equalTo: monthYearLabel.centerYAnchor),
            lastMonthButton.widthAnchor.constraint(equalToConstant: 38),
            lastMonthButton.heightAnchor.constraint(equalToConstant: 27),
            
            // Contraints monthYearLabel
            monthYearLabel.leftAnchor.constraint(equalTo: lastMonthButton.rightAnchor, constant: 10),
            monthYearLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            monthYearLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            monthYearLabel.rightAnchor.constraint(equalTo: nextMonthButton.leftAnchor, constant: -10),
            monthYearLabel.widthAnchor.constraint(equalToConstant: 120),
            monthYearLabel.heightAnchor.constraint(equalToConstant: 27),
            
            // Constraints nextMonthButton
            nextMonthButton.centerYAnchor.constraint(equalTo: monthYearLabel.centerYAnchor),
            nextMonthButton.widthAnchor.constraint(equalToConstant: 38),
            nextMonthButton.heightAnchor.constraint(equalToConstant: 27),
            ])
    }
    
}
