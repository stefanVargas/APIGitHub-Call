//
//  Extentions.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 10/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation
import UIKit


//MARK: UIView
extension UIView {
    
    func setWithroundCorners() {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
    }
    
    
    ///UIView Contraints Code
    func setupContraint(pattern: String, views: UIView...) {
        var myViews: [String : UIView] = [:]
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            myViews["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: pattern, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: myViews))
    }
    
    func setupContraint(pattern: String, options:NSLayoutConstraint.FormatOptions, views: UIView...) {
        var myViews: [String : UIView] = [:]
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            myViews["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: pattern, options: options, metrics: nil, views: myViews))
    }
    
}


//MARK: UIImageView
extension UIImageView {
    
    var imageCache: NSCache<AnyObject, AnyObject> {
        
        return  NSCache<AnyObject, AnyObject>()
    }
    
    func imageFromURL(_ imageString: String) {
        
        guard let imageURL = URL(string: imageString) else { return }
        if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: imageURL.absoluteString as AnyObject)
                    self.image = image
                }
            })
        }.resume()
    }
    
}


//MARK: UIColor
extension UIColor {
    
    static var gitWhite: UIColor { return UIColor.fromHex(hexValue: 0xFAFBFC)}
    
    static var gitBlack: UIColor { return UIColor.fromHex(hexValue: 0x24292E) }
    
    static var gitDarkGray: UIColor { return UIColor.fromHex(hexValue: 0x2B3137)}
    
    static var gitGray: UIColor { return UIColor.fromHex(hexValue: 0x3F4448) }
    
    static var gitMagenta: UIColor { return UIColor.fromHex(hexValue: 0xF34B7D) }
    
    static var gitGreen: UIColor { return UIColor.fromHex(hexValue: 0x2EBC4F) }
    
    
    static func fromHex(hexValue: UInt32) -> UIColor {
        
        let r = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let b = CGFloat((hexValue & 0x0000FF)) / 255.0
        let a = CGFloat(1.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
        
    }
}


//MARK: UINavigationBar
extension UINavigationBar {
    
    func appUINavigationBarLayout() {
        let navBarFont =  UIFont(name: Project.Fonts.gillSans.rawValue, size: 22)
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.gitBlack,
            NSAttributedString.Key.font: navBarFont,
            NSAttributedString.Key.underlineColor: UIColor.gitGreen,
            NSAttributedString.Key.backgroundColor: UIColor.clear,
        ]
        
        self.titleTextAttributes = attrs as [NSAttributedString.Key : Any]
    }
    
}


//MARK: RawRepresentable
extension RawRepresentable where RawValue == String {
    
    
    var localized: String {
        return NSLocalizedString(rawValue, comment: String())
    }
    
}
