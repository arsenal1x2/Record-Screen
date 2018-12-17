//
//  BrowserViewController.swift
//  RecordScreen
//
//  Created by LTT on 12/17/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var recordView: RecorderView!
    @IBOutlet weak var webNavigationView: WebNavigationView!
    @IBOutlet weak var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initViews()
    }

    func initViews() {
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
}

extension BrowserViewController: WKUIDelegate {
    web
}

