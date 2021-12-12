//
//  SignInUser.swift
//  GmailDemo
//
//  Created by 41nyaa on 2021/10/25.
//

import Foundation
import GoogleSignIn

struct GIDConfig: Codable {
    var CLIENT_ID: String
    var REVERSED_CLIENT_ID: String
    var PLIST_VERSION: String
    var BUNDLE_ID: String
}

class GIDSignInManager: ObservableObject {
    var user:  GIDGoogleUser?
    @Published var signedIn = false

    func signIn(viewController: UIViewController) {
        do {
            let url = Bundle.main.url(forResource: "client_id", withExtension:"plist")!
            let data = try Data(contentsOf: url)
            let config = try PropertyListDecoder().decode(GIDConfig.self, from: data)
            let signInConfig = GIDConfiguration(clientID: config.CLIENT_ID)
            GIDSignIn.sharedInstance.signIn(
               with: signInConfig,
               presenting: viewController
            ) { user, error in
                guard error == nil else { return }
                guard let user = user else { return }
                
                let gmailScope = "https://www.googleapis.com/auth/gmail.readonly"
                let grantedScopes = user.grantedScopes
                if grantedScopes == nil || !grantedScopes!.contains(gmailScope) {
                    print("don't have scope")
                    GIDSignIn.sharedInstance.addScopes([gmailScope], presenting: viewController) { user, error in
                        guard error == nil else { return }
                        guard let user = user else { return }
                        self.user = user
                        self.signedIn = true
                    }
                }
            }
        } catch {
            
        }
    }
    
    func singOut() {
        GIDSignIn.sharedInstance.signOut()
        self.signedIn = false
    }
    
    func setScopes(scopes: [String]){
    }
    
    func getUserId() -> String? {
        return user?.userID
    }

    func getAccessToken() -> String? {
        return user?.authentication.accessToken
    }
    
    func refresh(access: @escaping (String, String) -> Void ) {
        guard let user = user else { return }
        
        user.authentication.do { authentication, error in
            guard error == nil else { return }
            guard let authentication = authentication else { return }
            
            access(user.userID!, authentication.accessToken)
        }
    }

}
