//
//  NavigationViewController.swift
//  RecordScreen
//
//  Created by LTT on 123//19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        var bounds = navigationBar.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        let colorTop = UIColor(hexString: "40910a")
        let colorButtom = UIColor(hexString: "00ff00")
        gradient.colors = [colorTop.cgColor, colorButtom.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
        // Do any additional setup after loading the view.
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}
