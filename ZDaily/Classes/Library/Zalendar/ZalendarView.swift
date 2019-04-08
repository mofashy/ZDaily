//
//  ZalendarView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/6.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa


protocol ZalendarNavigator {
    var lastMonthButton: NSButton { get set }
    var nextMonthButton: NSButton { get set }
    var monthYearLabel: NSTextField { get set }
}


protocol ZalendarStack {
    var headView: NSView { get set }
    
    var scrollView: ZalendarScrollView { get set }
    var clipView: NSClipView { get set }
    var childView: NSView { get set }
    var pageView1: ZalendarGridView { get set }
    var pageView2: ZalendarGridView { get set }
    var pageView3: ZalendarGridView { get set }
}


class ZalendarScrollView: NSScrollView {
    
//    override func reflectScrolledClipView(_ cView: NSClipView) {
//        
//    }
//    
//    override func scrollWheel(with event: NSEvent) {
//        return
//    }
    
}


class ZalendarView: NSView, ZalendarNavigator, ZalendarStack {
    
    lazy var headView: NSView = {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: ZalendarScrollView = {
        let scrollView = ZalendarScrollView()
        scrollView.hasVerticalScroller = false
        scrollView.hasHorizontalRuler = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var clipView: NSClipView = {
        let clipView = NSClipView()
        clipView.translatesAutoresizingMaskIntoConstraints = false
        return clipView
    }()
    
    lazy var childView: NSView = {
        let childView = NSView()
        childView.translatesAutoresizingMaskIntoConstraints = false
        return childView
    }()
    
    lazy var pageView1: ZalendarGridView = {
        let pageView = ZalendarGridView()
        pageView.translatesAutoresizingMaskIntoConstraints = false
        return pageView
    }()
    
    lazy var pageView2: ZalendarGridView = {
        let pageView = ZalendarGridView()
        pageView.translatesAutoresizingMaskIntoConstraints = false
        return pageView
    }()
    
    lazy var pageView3: ZalendarGridView = {
        let pageView = ZalendarGridView()
        pageView.translatesAutoresizingMaskIntoConstraints = false
        return pageView
    }()
    

    lazy var lastMonthButton: NSButton = {
        let btn = NSButton()
        btn.title = ""
        btn.bezelStyle = .regularSquare
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    // Like: 四月 2019
    lazy var monthYearLabel: NSTextField = {
        let label = NSTextField()
        label.isEditable = false
        label.isBordered = false
        label.alignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextMonthButton: NSButton = {
        let btn = NSButton()
        btn.title = ""
        btn.bezelStyle = .regularSquare
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addSubviews()
        configLayouts()
        buildHead()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ZalendarView {
    
    func addSubviews() {
        addNavigator()
        addStack()
    }
    
    func configLayouts() {
        layoutNavigator()
        layoutStack()
    }
}



