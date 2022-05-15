//
//  Helper.swift
//  AAS
//
//  Created by Shibzukhov Astemir on 14.05.2022.
//

import UIKit


extension UIView {
    func makeConstraints(to view: UIView, top: CGFloat? = nil, leading: CGFloat? = nil, trailing: CGFloat? = nil, bottom: CGFloat? = nil) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        if let top = top {
            constraints.append(self.topAnchor.constraint(equalTo: view.topAnchor, constant: top))
        }
        
        if let leading = leading {
            constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading))
        }
        
        if let trailing = trailing {
            constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing))
        }
        
        if let bottom = bottom {
            constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom))
        }
        
        return constraints
    }
    
    func makeDefaultConstraints(to view: UIView) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(self.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        return constraints
    }
}
