//
//  GMailBodyView.swift
//  GmailDemo
//
//  Created by 41nyaa on 2021/11/06.
//

import SwiftUI

struct GMailMailListView: View {
    @EnvironmentObject var signInMgr: GIDSignInManager
    @EnvironmentObject var gmailVM: GMailViewModel
    var label: String

    var body: some View {
        List {
            ForEach(gmailVM.threads.threads) { thread in
                NavigationLink(thread.snippet, destination: GMailMailView(id: thread.id))
            }
        }
        .onAppear() {
            self.gmailVM.labelId = self.label
            self.signInMgr.refresh(access: self.gmailVM.getThreads)
        }
    }
}

//struct GMailBodyView_Previews: PreviewProvider {
//    static var previews: some View {
//        GMailMailListView()
//    }
//}
