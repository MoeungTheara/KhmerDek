//
//  searchBar+Extension.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/27/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

extension UISearchBar {
    var textField: UITextField? {
        return subviews.first?.subviews.first(where: { $0.isKind(of: UITextField.self) }) as? UITextField
    }
}
