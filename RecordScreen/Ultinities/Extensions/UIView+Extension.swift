//
//  UIView+Extension.swift
//  RecordScreen
//
//  Created by LTT on 12/17/18.
//  Copyright © 2018 LTT. All rights reserved.
//

import UIKit

extension UIView {
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }

    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }

    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }

    var leading: CGFloat {
        return self.frame.origin.x
    }

    var trailing: CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }

    var top: CGFloat {
        return self.frame.origin.y
    }

    var bottom: CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }

    var position: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }

    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }

    @IBInspectable var viewBorderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    public class func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    public class func loadNib<T: UIView>() -> T! {
        let name = String(describing: self)
        let bundle = Bundle(for: T.self)
        guard let xib = bundle.loadNibNamed(name, owner: nil, options: nil)?.first as? T else {
            fatalError("Cannot load nib named `\(name)`")
        }
        return xib
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return UIView()
        }
        return view
    }

    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius

        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func shake(duration: CFTimeInterval = 0.07, repeatCount: Float = 3) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }

    enum ViewSide {
        case left, right, top, bottom
    }

    func addBorder(toSide sides: ViewSide..., withColor color: UIColor, andThickness thickness: CGFloat) {
        for side in sides {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            switch side {
            case .left: border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
            case .right: border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
            case .top: border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
            case .bottom: border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
            }
            self.layoutIfNeeded()
            layer.addSublayer(border)
        }
    }

    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.orange, UIColor.yellow]
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }

    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        let colorTop = UIColor(hexString: "40910a")
        let colorButtom = UIColor(hexString: "00ff00")
        gradientLayer.colors = [colorButtom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func removeAllSubviews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
}
