//
//  Storyboardable.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 05.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import UIKit

@objc public protocol Storyboardable { }

public extension Storyboardable where Self: UIViewController {
    static func instantiateInitialFromStoryboard() -> Self {
        let storyboard = self.storyboard()
        let controller = storyboard.instantiateInitialViewController()
        return controller! as! Self
    }
    
    static func storyboard(fileName: String? = nil) -> UIStoryboard {
        let name = fileName ?? self.storyboardIdentifier
        let bundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        return storyboard
    }
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static var storyboardName: String {
        return self.storyboardIdentifier
    }
}
