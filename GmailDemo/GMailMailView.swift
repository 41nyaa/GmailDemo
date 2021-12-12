//
//  GMailMailView.swift
//  GmailDemo
//
//  Created by 41nyaa on 2021/11/14.
//

import SwiftUI
import WebKit

struct GMailMailView: View {
    @EnvironmentObject var signInMgr: GIDSignInManager
    @EnvironmentObject var gmailVM: GMailViewModel
    var id: String
    
    var body: some View {
        VStack {
            if self.gmailVM.message.payload != nil {
                WebView(data: $gmailVM.data)
            }
        }
        .onAppear() {
            self.gmailVM.id = self.id
            self.signInMgr.refresh(access: self.gmailVM.getMessage)
        }

    }
}

struct WebView: UIViewRepresentable {
  @Binding var data: String
   
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
   
  func updateUIView(_ uiView: WKWebView, context: Context) {
    uiView.loadHTMLString(data, baseURL: nil)
  }
}

//struct GMailMailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GMailMailView()
//    }
//}
