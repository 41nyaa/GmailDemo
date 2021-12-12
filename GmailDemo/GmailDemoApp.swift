//
//  GmailDemoApp.swift
//  GmailDemo
//
//  Created by 41nyaa on 2021/10/16.
//

import SwiftUI

@main
struct GmailDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GIDSignInManager())
                .environmentObject(GMailViewModel())
        }
    }
}
