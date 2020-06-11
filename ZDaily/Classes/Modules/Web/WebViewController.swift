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
    private var commentViewController: CommentListViewController?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        webView.navigationDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTodayExtesionOpenUrl(_:)), name: Notis.name.TodayExtensionCallbackNotification, object: nil)
    }
    
    func push2Comment() {
        let storyboard = NSStoryboard(name: "Comment", bundle: nil)
        guard let viewController = storyboard.instantiateInitialController() as? CommentListViewController else {
            print("Fail to load comments vc")
            return
        }
        viewController.id = id
        commentViewController = viewController
        present(viewController, animator: PushAnimator())
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


extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let url = url {
            if url.absoluteString.contains("/p/") ||
                url.absoluteString.contains("/question") {
                push2Comment()
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
}


extension WebViewController {
    
    func load<T>(_ story: T) where T: ZDStory {
        self.id = story.id
        
        request(story.id)
    }
    
    fileprivate func request(_ id: Int) {
        if commentViewController != nil {
            commentViewController?.dismiss(commentViewController)
            commentViewController = nil
        }
        
        activityIndicator?.startAnimation(nil)
        RT.send(LatestStoryDetailRequest(id)).parse(StoryDetail.self).done { [unowned self] detail in
            guard var body = detail.body else { return }
            if let css = detail.css?.first {
                body = body.appendingFormat("<link rel=\"stylesheet\" type=\"text/css\" href=\"\(css)\" />\n ")
            }
            if let js = detail.js?.first {
                body = body.appendingFormat("<script src=\"\(js)\"></script>")
            }
            let localCSS = String(format: "<style type=\"text/css\">.img-place-holder {background:url(%@);background-size: cover;}", detail.image!)
            body = body.appending(localCSS)
            self.webView.loadHTMLString(body, baseURL: nil)
            self.activityIndicator?.stopAnimation(nil)
        }.catch { [unowned self] error in
            self.activityIndicator?.stopAnimation(nil)
            debugPrint(error)
        }
    }
    
}
