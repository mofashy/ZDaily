//
//  WebViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa
import WebKit

class WebViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    
    private var id = 0
    private var isCommentsVcAppear = false {
        didSet {
            if oldValue {
                commentsVc.view.removeFromSuperview()
            }
        }
    }
    private var commentsVc: CommentsViewController!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        webView.navigationDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTodayExtesionOpenUrl(_:)), name: Notis.name.TodayExtensionCallbackNotification, object: nil)
        
        loadCommentsVc()
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
        
        guard isCommentsVcAppear else { return }
        var frame = commentsVc.view.frame
        frame.origin.x = view.frame.width - frame.width
        frame.size.height = view.frame.height
        commentsVc.view.frame = frame
    }
    
    func switchCommentsVc() {
        guard isCommentsVcAppear == false else { return }
        present(commentsVc, animator: PresentCommentsAnimator())
        isCommentsVcAppear = true
        
        commentsVc.request(id, true)
    }
    
    @objc func handleTodayExtesionOpenUrl(_ noti: Notification) {
        guard let obj = noti.object as? [String: Any] else {
            return
        }
        guard let id = obj["id"] as? Int else { return }
        self.id = id
        request(id)
    }
    
}


extension WebViewController {
    
    func loadCommentsVc() {
        guard let storyboard = self.storyboard else { return }
        guard let commentsVc = storyboard.instantiateController(withIdentifier: "CommentsViewController") as? CommentsViewController else {
            print("Fail to load comments vc")
            return
        }
        
        commentsVc.disapearHandler = { [weak self] ()->Void in
            self?.isCommentsVcAppear = false
        }
        self.commentsVc = commentsVc
        addChild(commentsVc)
        view.addSubview(commentsVc.view)
        
        commentsVc.view.frame = NSRect(x: view.frame.maxX, y: 0, width: 320, height: view.frame.height)
    }
    
}


extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let url = url {
            if url.absoluteString.contains("/p/") ||
                url.absoluteString.contains("/question") {
                // 加载评论
                switchCommentsVc()
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
}


extension WebViewController {
    
    func request(_ id: Int) {
        self.id = id
        
        commentsVc.dismiss(nil)
        isCommentsVcAppear = false
        
        Rocket.request(Apis.News.detail(id).url, method: .get, params: nil) { [weak self] (result) in
            switch result {
            case .success(let keyValues):
                let news = News(keyValues)
                var html = news.body
                if let css = news.css.first {
                    html = html.appendingFormat("<link rel=\"stylesheet\" type=\"text/css\" href=\"\(css)\" />\n ")
                }
                if let js = news.js.first {
                    html = html.appendingFormat("<script src=\"\(js)\"></script>")
                }
                self?.webView.loadHTMLString(html, baseURL: nil)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
}
