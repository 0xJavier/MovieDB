//
//  UIView+Extension.swift
//  MovieDB
//
//  Created by Javier Munoz on 4/25/22.
//

import UIKit

extension UIView {
    func center(in parent: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parent.topAnchor),
            leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            trailingAnchor.constraint(equalTo: parent.trailingAnchor),
        ])
    }
}
