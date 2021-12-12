//
//  GMailLabelView.swift
//  GmailDemo
//
//  Created by 41nyaa on 2021/10/30.
//

import SwiftUI

struct GMailLabelListView: View {
    @EnvironmentObject var signInMgr: GIDSignInManager
    @EnvironmentObject var gmailVM: GMailViewModel
    
    var body: some View {
            Button(action: {
                signInMgr.singOut()
            }) {
                Text("logout")
            }
            NavigationView {
                List {
                    ForEach(self.gmailVM.labels.labels) { label in
                        NavigationLink(label.name, destination: GMailMailListView(label: label.id))
                    }
                }
        }.onAppear(perform: {
            self.signInMgr.refresh(access: self.gmailVM.getLabel)
        })
    }
}

//struct MailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GMailView()
//    }
//}
