//
//  CCDataLoadingVC.swift
//  CleanCrypto
//
//  Created by David Ruvinskiy on 7/31/22.
//

import UIKit
import Lottie

class CCDataLoadingVC: UIViewController {

    var containerView = UIView()

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)

        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }

        let animationView = AnimationView(name: "97930-loading")
        containerView.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5

        animationView.play()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
        }
    }
}
