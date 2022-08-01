//
//  UITableView+Ext.swift
//  CleanCrypto
//
//  Created by David Ruvinskiy on 7/29/22.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
