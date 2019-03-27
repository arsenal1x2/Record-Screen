//
//  BrowserViewController.swift
//  RecordScreen
//
//  Created by LTT on 12/17/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import WebKit

@objc protocol BrowserViewControllerDelegate: class {
    @objc optional func webviewDidFinishLoad(canGoBack: Bool, cangoForward: Bool)
}
class BrowserViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var recordView: RecorderView!
    @IBOutlet weak var webNavigationView: WebNavigationView!
    @IBOutlet weak var webview: WKWebView!
    weak var delegateWebNavigationView: BrowserViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        guard let url = URL(string: "https://www.google.com.vn/") else {
            return
        }
        let urlRequest = URLRequest(url: url)
        webview.load(urlRequest)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       initViews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initViews()
        //navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func loadView() {
        super.loadView()
        initViews()
    }
    
    func initViews() {
        webview.navigationDelegate = self
        webNavigationView.delegate = self
        recordView.delegate = self
        delegateWebNavigationView = webNavigationView
        navigationController?.navigationBar.isHidden = true
        mainView.setGradientBackground()
        topView.setGradientBackground()
        bottomView.setGradientBackground()
        
    }
}

extension BrowserViewController: WebNavigationViewDelegate {
    func webNavigationViewDidClickBackButton() {
        webview.goBack()
    }

    func webNavigationViewDidClickPrevButton() {
        webview.goForward()
    }
    func didFinishWebAdressTextField(url: URL) {
        let urlRequest = URLRequest(url: url)
        webview.load(urlRequest)
    }

    func webNavigationViewDidClickReloadButton() {
        webview.reload()
    }
}

extension BrowserViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        delegateWebNavigationView?.webviewDidFinishLoad?(canGoBack: webView.canGoBack, cangoForward: webView.canGoForward)
    }
}

extension BrowserViewController: RecorderViewDelegate {
    func recorderViewDidClickedClosedButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

