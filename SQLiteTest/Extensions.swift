//
//  Extensions.swift
//  SQLiteTest
//
//  Created by Nick Lin on 2018/2/1.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension UITableView {
    func registerCell<T: UITableViewCell>(type: T.Type) {
        register(type, forCellReuseIdentifier: type.className)
    }

    func registerCells<T: UITableViewCell>(types: [T.Type]) {
        types.forEach { registerCell(type: $0) }
    }

    func dequeueCell<T: UITableViewCell>(type: T.Type) -> T {
        // swiftlint:disable force_cast
        return self.dequeueReusableCell(withIdentifier: type.className) as! T
        // swiftlint:enable force_cast
    }
}
