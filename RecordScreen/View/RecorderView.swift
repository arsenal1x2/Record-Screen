//
//  RecorderView.swift
//  RecordScreen
//
//  Created by LTT on 12/17/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

@objc protocol RecorderViewDelegate {
    func recorderViewDidClickedClosedButton()
}

class RecorderView: UIView {

    @IBOutlet var contentView: UIView!
    weak var delegate: RecorderViewDelegate?

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
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func clickClosingButton(_ sender: Any) {
        delegate?.recorderViewDidClickedClosedButton()
    }
}
