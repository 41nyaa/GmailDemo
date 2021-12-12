//
//  ContentView.swift
//  GmailDemo
//
//  Created by 41nyaa on 2021/10/16.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var signInMgr: GIDSignInManager
    
    var body: some View {
        Group {
            if !signInMgr.signedIn {
                GIDSignInView(signInMgr: signInMgr)
                .frame(width: 125, height: 50)
            } else {
                GMailLabelListView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
