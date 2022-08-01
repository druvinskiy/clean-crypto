//
//  UIViewController+Ext.swift
//  CleanCrypto
//
//  Created by David Ruvinskiy on 8/1/22.
//

import UIKit

extension UIViewController {
    
    func presentCCAlertOnMainThread(title: String, message: String, buttonTitle: String) {
            
            DispatchQueue.main.async {
                let alertVC = CCAlertVC(title: title, message: message, buttonTitle: buttonTitle)
                alertVC.modalPresentationStyle = .overFullScreen
                alertVC.modalTransitionStyle = .crossDissolve
                self.present(alertVC, animated: true)
            }
        }
}
