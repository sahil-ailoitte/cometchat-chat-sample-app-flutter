//
//  Extensions.swift
//  cometchatcalls_plugin
//
//  Created by admin on 15/05/23.
//

import Foundation
import UIKit

extension UIView {
    func addActivityIndicator() {
        var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        }
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        
        // Constraints to center activity indicator in the view
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Add a black background view behind the activity indicator
        self.backgroundColor = UIColor.black
        
        // Start animating the activity indicator
        activityIndicator.startAnimating()
    }
}

