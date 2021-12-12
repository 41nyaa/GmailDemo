//
//  LoginButton.swift
//  GmailDemo
//
//  Created by 41nyaa on 2021/10/16.
//

import SwiftUI
import UIKit
import GoogleSignIn

class GIDSignInViewController: UIViewController {
    var si
    override func viewDidLoad() {
        let button = GIDSignInButton()
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.bounds = CGRect(x: 0, y: 0, width: 100, height: 10)
        view.addSubview(button)
        
        view.backgroundColor = .green
    }
    
    @objc func login() {
    }
}
