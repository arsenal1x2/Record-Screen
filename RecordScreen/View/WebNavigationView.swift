//
//  WebNavigationView.swift
//  RecordScreen
//
//  Created by LTT on 12/17/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

@objc protocol WebNavigationViewDelegate {
    func webNavigationViewDidClickBackButton()
    func webNavigationViewDidClickPrevButton()
    func didFinishWebAdressTextField(url: URL)
    func webNavigationViewDidClickReloadButton()
}

class WebNavigationView: UIView {
    @IBOutlet weak var webAddressTextField: UITextField!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var webAddressView: UIView!
    @IBOutlet var contentView: UIView!
    weak var delegate: WebNavigationViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    private func initView() {
        _ = loadViewFromNib()
        self.backgroundColor = UIColor.clear
        webAddressView.layer.cornerRadius = webAddressView.frame.height / 4.0
        webAddressView.clipsToBounds = true
        addSubview(contentView)
        webAddressTextField.delegate = self
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    @IBAction func clickReloadButton(_ sender: Any) {
        delegate?.webNavigationViewDidClickReloadButton()
    }

    @IBAction func clickHistoryButton(_ sender: Any) {
    }

    @IBAction func clickFavoriteButton(_ sender: Any) {
    }

    @IBAction func clickBackButton(_ sender: Any) {
        delegate?.webNavigationViewDidClickBackButton()
    }

    @IBAction func clickPrevButton(_ sender: Any) {
        delegate?.webNavigationViewDidClickPrevButton()
    }

}

// #MARK: UITextFieldDelegate

extension WebNavigationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard var webAdress = webAddressTextField.text else {
            return true
        }
        if webAdress.hasPrefix("http://") || webAdress.hasPrefix("https://"){
            loadURL(urlString: webAdress)
        } else {
            webAdress = "http://\(webAdress)"
            loadURL(urlString: webAdress)
        }
       webAddressTextField.endEditing(true)
        
        return true
    }

    func loadURL(urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            delegate?.didFinishWebAdressTextField(url: url)
        } else {
            let url = urlString.getLinkSearchKey()
           delegate?.didFinishWebAdressTextField(url: url)
        }
        self.webAddressTextField.text = urlString
    }
}

// #MARK: BroserViewControllerDelegate

extension WebNavigationView: BrowserViewControllerDelegate {
    func webviewDidFinishLoad(canGoBack: Bool, cangoForward: Bool) {
        if canGoBack {
            backButton.isEnabled = true
        } else {
            backButton.isEnabled = false
        }
        if cangoForward {
            prevButton.isHidden = false
        } else {
            prevButton.isHidden = true
        }

    }
    
}
