//
//  GIDSignInView.swift
//  GmailDemo
//
//  Created by 41nyaa on 2021/10/16.
//

import SwiftUI

struct GIDSignInView: UIViewControllerRepresentable {
    var signInMgr: GIDSignInManager

    func makeUIViewController(context: Context) -> GIDSignInViewController {
        let viewController = GIDSignInViewController()
        viewController.signInMgr = signInMgr
        return viewController
    }

    func updateUIViewController(_ viewController: GIDSignInViewController,
                                context: Context) {
    }
}
