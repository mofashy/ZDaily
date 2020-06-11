//
//  LatestBannerView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/9.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa
import Kingfisher

class LatestBannerItem: NSCollectionViewItem {
    lazy var coverView: NSImageView = {
        let coverView = NSImageView()
        coverView.imageScaling = .scaleNone
        return coverView
    }()
    
    var story: TopStory? {
        didSet {
            guard let s = story else { return }
            coverView.loadImage(s.image)
        }
    }
    
    override func loadView() {
        view = coverView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func _setup() {
        
    }
}


class LatestBannerView: NSTableHeaderView, NibLoadable {
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var stories: [TopStory]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func column(at point: NSPoint) -> Int {
        return -1
    }
    
    override func headerRect(ofColumn column: Int) -> NSRect {
        return NSRect.zero
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(LatestBannerItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("LatestBannerItem"))
    }
}


extension LatestBannerView: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories?.count ?? 0
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("LatestBannerItem"), for: indexPath) as! LatestBannerItem
        item.story = stories?[indexPath.item]
        return item
    }
    
    
}


extension LatestBannerView: NSCollectionViewDelegate {
    
}


extension LatestBannerView: NSCollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return CGSize(width: frame.width - 20, height: frame.height - 20)
    }
}


class LatestListCellView: NSTableCellView {
    @IBOutlet weak var coverView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    
    var story: Story? {
        didSet {
            guard let s = self.story else { return }
            
            titleLabel.stringValue = s.title ?? ""
            coverView.loadImage(s.images?.first)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.maximumNumberOfLines = 2
    }
}


extension NSImageView {
    
    func loadImage(_ url: String?) {
        guard let url = url else { return }
        let size = self.bounds.size
        let scale = NSScreen.main!.backingScaleFactor
        let processor = DownsamplingImageProcessor(size: CGSize(width: size.width * scale, height: size.height * scale))
        kf.setImage(
        with: URL(string: url),
        placeholder: nil,
        options: [
            .processor(processor),
            .scaleFactor(NSScreen.main!.backingScaleFactor),
            .transition(.none),
            .cacheOriginalImage
        ])
    }
}



