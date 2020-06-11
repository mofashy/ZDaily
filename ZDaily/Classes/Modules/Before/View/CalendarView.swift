//
//  CalendarView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

typealias DateChanged = (String) -> Void

class CalendarView: NSTableHeaderView, NibLoadable {
    
    var dateChanged: DateChanged?
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var dateLabel: NSTextField!
    
    private var date: Date!
    private var today: Date!
    private var year = 0
    private var month = 0
    private var prevMonthDays = [CalendarDate]()
    private var thisMonthDays = [CalendarDate]()
    private var nextMonthDays = [CalendarDate]()
    private var selectionIndexPaths: Set<IndexPath>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _setup()
    }
    
    override func column(at point: NSPoint) -> Int {
        return -1
    }
    
    override func headerRect(ofColumn column: Int) -> NSRect {
        return NSRect.zero
    }
    
    private func _setup() {
        date = Date()
        today = date
        
        year = CU.year(from: date)
        month = CU.month(from: date)
        
        configPrevMonthDays()
        configThisMonthDays()
        configNextMonthDays()
        
        collectionView.register(CalendarViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("CalendarViewItem"))
        selectionIndexPaths = [IndexPath(item: CU.day(from: today), section: 0)]
        collectionView.selectionIndexPaths = selectionIndexPaths
        
        dateLabel.stringValue = DU.zdailyCalendarMonthYear(today)
    }
    
    @IBAction func lastMonthAction(_ sender: Any) {
        lastMonth()
    }
    
    @IBAction func nextMonthAction(_ sender: Any) {
        nextMonth()
    }
}


extension CalendarView {
    
    private func lastMonth() {
        date = CU.lastMonth(date)
        year = CU.year(from: date)
        month = CU.month(from: date)
        
        configPrevMonthDays()
        configThisMonthDays()
        configNextMonthDays()
        collectionView.reloadData()
        collectionView.selectionIndexPaths = selectionIndexPaths
        dateLabel.stringValue = DU.zdailyCalendarMonthYear(date)
    }
    
    private func nextMonth() {
        date = CU.nextMonth(date)
        year = CU.year(from: date)
        month = CU.month(from: date)
        
        configPrevMonthDays()
        configThisMonthDays()
        configNextMonthDays()
        collectionView.reloadData()
        collectionView.selectionIndexPaths = selectionIndexPaths
        dateLabel.stringValue = DU.zdailyCalendarMonthYear(date)
        
//        let clipView = scrollView.contentView
//        clipView.bounds = NSRect(x: clipView.bounds.width, y: 0, width: clipView.bounds.width, height: clipView.bounds.height)
//        let animation = NSViewAnimation(viewAnimations: [
//            [NSViewAnimation.Key.startFrame: collectionView.bounds,
//             NSViewAnimation.Key.endFrame: NSRect(x: -collectionView.bounds.width, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height),
//             NSViewAnimation.Key.target: collectionView as Any,
//             NSViewAnimation.Key.effect: NSViewAnimation.EffectName.fadeIn]
//            ])
//        animation.duration = 0.25
        
//        collectionView.scrollToItems(at: [IndexPath(item: 0, section: 1)], scrollPosition: .left)
//        animation.start()
    }
    
    func configPrevMonthDays() {
        prevMonthDays.removeAll()
        
        let year = self.month == 1 ? self.year - 1 : self.year
        let month = self.month == 1 ? 12 : self.month - 1
        
        let firstWeekday = CU.firstWeekdayInThisMonth(date)
        let lastMonthDate = CU.lastMonth(date)
        let daysInLastMonth = CU.totalDaysInThisMonth(lastMonthDate)
        
        var i = firstWeekday-1
        while i >= 0 {
            var m = CalendarDate()
            m.day = daysInLastMonth - i
            m.date = String(format: "%d%02d%02d", year, month, m.day)
            prevMonthDays.append(m)
            i -= 1
        }
    }
    
    func configThisMonthDays() {
        thisMonthDays.removeAll()
        
        let daysInThisMonth = CU.totalDaysInThisMonth(date)
        
        for i in 1...daysInThisMonth {
            var m = CalendarDate()
            m.day = i
            m.date = String(format: "%d%02d%02d", year, month, m.day)
            thisMonthDays.append(m)
        }
    }
    
    func configNextMonthDays() {
        nextMonthDays.removeAll()
        
        let year = self.month == 12 ? self.year + 1 : self.year
        let month = self.month == 12 ? 1 : self.month + 1
        
        let daysInThisMonth = CU.totalDaysInThisMonth(date)
        let firstWeekday = CU.firstWeekdayInThisMonth(date)
        var i = 1, j = firstWeekday+daysInThisMonth
        while j < 42 {
            var m = CalendarDate()
            m.day = i
            m.date = String(format: "%d%02d%02d", year, month, m.day)
            nextMonthDays.append(m)
            i += 1
            j += 1
        }
    }
}


extension CalendarView: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("CalendarViewItem"), for: indexPath) as! CalendarViewItem
        let daysInThisMonth = CU.totalDaysInThisMonth(date)
        let firstWeekday = CU.firstWeekdayInThisMonth(date)
        var day = 0
        
        if indexPath.item < firstWeekday {
            item.CalendarDate = prevMonthDays[indexPath.item]
            item.label.textColor = NSColor.systemGray
        } else if indexPath.item < firstWeekday+daysInThisMonth {
            day = indexPath.item-firstWeekday+1
            item.CalendarDate = thisMonthDays[indexPath.item-prevMonthDays.count]
            item.label.textColor = NSColor.textColor
        } else {
            item.CalendarDate = nextMonthDays[indexPath.item-prevMonthDays.count-thisMonthDays.count]
            item.label.textColor = NSColor.systemGray
        }
            
        if today == date && day == CU.day(from: date) {
            item.label.textColor = NSColor.red
        }
        
        return item
    }
    
}


extension CalendarView: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else {
            return
        }
        guard let handler = dateChanged else {
            return
        }
        guard let cell = collectionView.item(at: indexPath) as? CalendarViewItem else {
            return
        }
        guard let m = cell.CalendarDate else { return }
        handler(m.date)
    }
    
}


extension CalendarView: NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return CGSize(width: floor(258.0/7.0), height: floor(172.0/6.0))
    }
    
}


class CalendarViewItem: NSCollectionViewItem {
    lazy var label: NSTextField = {
        let label = NSTextField()
        label.isEditable = false
        label.alignment = .center
        return label
    }()
    
    var CalendarDate: CalendarDate? {
        didSet {
            guard let m = CalendarDate else { return }
            label.stringValue = "\(m.day)"
        }
    }
    
    override var isSelected: Bool {
        didSet {
            view.layer?.borderWidth = isSelected ? 1 : 0
        }
    }
    
    override func loadView() {
        view = label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.borderColor = NSColor.systemRed.cgColor
        view.layer?.borderWidth = 0
    }
}


class FixedScrollView: NSScrollView {
    
    override func scroll(_ clipView: NSClipView, to point: NSPoint) {
        return
    }
    
}
