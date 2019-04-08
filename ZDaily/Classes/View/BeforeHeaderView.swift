//
//  BeforeHeaderView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/5.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class BeforeViewItem: NSCollectionViewItem {
    
    lazy var label: NSTextField = {
        let label = NSTextField()
        label.isEditable = false
//        label.isBezeled = false
        label.alignment = .center
        return label
    }()
    
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


class BeforeHeaderView: NSTableHeaderView {
    
    private var scrollView: FixedScrollView!
    private var clipView: NSClipView!
    private var collectionView: NSCollectionView!
    private var date: Date!
    private var weekDayArray: [String]!
    private var prevMonthDays = [Int]()
    private var thisMonthDays = [Int]()
    private var nextMonthDays = [Int]()
    private var today: Date!
    private var year = ""
    private var month = ""
    private var prevMonthButton: NSButton!
    private var nextMonthButton: NSButton!
    private var label: NSTextField!
    private var selectionIndexPaths: Set<IndexPath>!
    
    var changeDateHandler: ((String)->Void)?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        weekDayArray = ["日", "一", "二", "三" ,"四", "五", "六"]
        
        setup()
        buildHead()
        
        date = Date()
        today = date
        
        configPrevMonthDays()
        configThisMonthDays()
        configNextMonthDays()
        
        let width: CGFloat = CGFloat(Int((frameRect.width-8)/7))
        let height: CGFloat = CGFloat(180/7)
        
        let layout = NSCollectionViewFlowLayout()
        layout.sectionInset = NSEdgeInsetsZero
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = NSCollectionView(frame: NSRect(x: 0, y: 0, width: frame.width-8, height: 150))
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColors = [NSColor.white]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isSelectable = true
        collectionView.allowsEmptySelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.register(BeforeViewItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("BeforeViewItem"))
        
        collectionView.selectionIndexPaths = [IndexPath(item: SingleCalender.shared.day(from: today), section: 0)]
        selectionIndexPaths = collectionView.selectionIndexPaths
        
        clipView = NSClipView()
        clipView.frame = NSRect(x: 0, y: 0, width: frame.width-8, height: 150)
        clipView.documentView = collectionView
        
        scrollView = FixedScrollView()
        scrollView.frame = NSRect(x: 4, y: 63, width: frame.width-8, height: 150)
        scrollView.contentView = clipView
        addSubview(scrollView)
        
//        let zalendarView = ZalendarView(frame: NSRect(x: 4, y: 0, width: frameRect.width-8, height: frameRect.height))
//        addSubview(zalendarView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func column(at point: NSPoint) -> Int {
        return -1
    }
    
    override func headerRect(ofColumn column: Int) -> NSRect {
        return NSRect.zero
    }
    
}


extension BeforeHeaderView {
    
    func setup() {
        prevMonthButton = NSButton()
        prevMonthButton.title = ""
        prevMonthButton.image = NSImage(named: "last")
        prevMonthButton.bezelStyle = .regularSquare
        prevMonthButton.translatesAutoresizingMaskIntoConstraints = false
        prevMonthButton.target = self
        prevMonthButton.action = #selector(lastMonth)
        addSubview(prevMonthButton)
        
        label = NSTextField()
        label.isEditable = false
        label.isBordered = false
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.stringValue = SingleDateFormatter.shared.zdailyCalendarMonthYear(Date())
        addSubview(label)
        
        nextMonthButton = NSButton()
        nextMonthButton.title = ""
        nextMonthButton.image = NSImage(named: "next")
        nextMonthButton.bezelStyle = .regularSquare
        nextMonthButton.translatesAutoresizingMaskIntoConstraints = false
        nextMonthButton.target = self
        nextMonthButton.action = #selector(nextMonth)
        addSubview(nextMonthButton)
        
        NSLayoutConstraint.activate([
            prevMonthButton.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            prevMonthButton.widthAnchor.constraint(equalToConstant: 38),
            prevMonthButton.heightAnchor.constraint(equalToConstant: 27),
            
            label.leftAnchor.constraint(equalTo: prevMonthButton.rightAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.rightAnchor.constraint(equalTo: nextMonthButton.leftAnchor, constant: -10),
            label.widthAnchor.constraint(equalToConstant: 120),
            label.heightAnchor.constraint(equalToConstant: 27),
            
            nextMonthButton.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            nextMonthButton.widthAnchor.constraint(equalToConstant: 38),
            nextMonthButton.heightAnchor.constraint(equalToConstant: 27),
        ])
    }
    
    func buildHead() {
        for i in 0..<weekDayArray.count {
            let label = NSTextField()
            label.isEditable = false
            label.alignment = .center
            label.isBezeled = false
            label.textColor = NSColor.textColor
            label.stringValue = weekDayArray[i]
            label.frame = NSRect(x: i*36+4, y: 38, width: 36, height: 25)
            addSubview(label)
        }
    }
}


extension BeforeHeaderView {
    
    @objc func lastMonth() {
        date = SingleCalender.shared.lastMonth(date)
        configPrevMonthDays()
        configThisMonthDays()
        configNextMonthDays()
        collectionView.reloadData()
        collectionView.selectionIndexPaths = selectionIndexPaths
        label.stringValue = SingleDateFormatter.shared.zdailyCalendarMonthYear(date)
    }
    
    @objc func nextMonth() {
        date = SingleCalender.shared.nextMonth(date)
        configPrevMonthDays()
        configThisMonthDays()
        configNextMonthDays()
        collectionView.reloadData()
        collectionView.selectionIndexPaths = selectionIndexPaths
        label.stringValue = SingleDateFormatter.shared.zdailyCalendarMonthYear(date)
        
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
        
        let firstWeekday = SingleCalender.shared.firstWeekdayInThisMonth(date)
        let lastMonthDate = SingleCalender.shared.lastMonth(date)
        let daysInLastMonth = SingleCalender.shared.totalDaysInThisMonth(lastMonthDate)
        
        var i = firstWeekday-1
        while i >= 0 {
            prevMonthDays.append(daysInLastMonth-i)
            i -= 1
        }
    }
    
    func configThisMonthDays() {
        thisMonthDays.removeAll()
        
        let daysInThisMonth = SingleCalender.shared.totalDaysInThisMonth(date)
        
        for i in 1...daysInThisMonth {
            thisMonthDays.append(i)
        }
    }
    
    func configNextMonthDays() {
        nextMonthDays.removeAll()
        
        let daysInThisMonth = SingleCalender.shared.totalDaysInThisMonth(date)
        let firstWeekday = SingleCalender.shared.firstWeekdayInThisMonth(date)
        var i = 1, j = firstWeekday+daysInThisMonth
        while j < 42 {
            nextMonthDays.append(i)
            i += 1
            j += 1
        }
    }
    
}


extension BeforeHeaderView: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("BeforeViewItem"), for: indexPath) as! BeforeViewItem
        let daysInThisMonth = SingleCalender.shared.totalDaysInThisMonth(date)
        let firstWeekday = SingleCalender.shared.firstWeekdayInThisMonth(date)
        var day = 0
        
        if indexPath.item < firstWeekday {
            item.label.stringValue = "\(prevMonthDays[indexPath.item])"
            item.label.textColor = NSColor.systemGray
        } else if indexPath.item < firstWeekday+daysInThisMonth {
            day = indexPath.item-firstWeekday+1
            item.label.stringValue = "\(thisMonthDays[indexPath.item-prevMonthDays.count])"
            item.label.textColor = NSColor.textColor
        } else {
            item.label.stringValue = "\(nextMonthDays[indexPath.item-prevMonthDays.count-thisMonthDays.count])"
            item.label.textColor = NSColor.systemGray
        }
            
        if today == date && day == SingleCalender.shared.day(from: date) {
            item.label.textColor = NSColor.red
        }
        
        return item
    }
    
}


extension BeforeHeaderView: NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let indexPath = indexPaths.first else {
            return
        }
        guard let handler = changeDateHandler else {
            return
        }
        //TODO:
    }
    
}
