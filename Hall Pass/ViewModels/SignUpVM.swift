//
//  LoginVM.swift
//  Hall Pass
//
//  Created by Ashton George on 3/9/22.
//


import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseFirestore

class SignUpViewModel: ObservableObject {
    
    @Published var isLogin: Bool = false
    let user = Auth.auth().currentUser
    private var db = Firestore.firestore()
    var signedInStudent = Student(id: "", name: "", email: "")
    
    func encodeSignIn() {
    
        do {
    
            // Create JSON Encoder
            let encoder = JSONEncoder()
    
            // Encode login
            let data = try encoder.encode(isLogin)
    
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "signin")
    
        } catch {
            print("Unable to Encode Array of Favorites: (\(error))")
        }
    
    }
    
    
    func decodeSignIn() {
    
            // read/get data
            if let data = UserDefaults.standard.data(forKey: "signin") {
    
                do {
    
                    // Create JSON Decoder
                    let decoder = JSONDecoder()
    
                    // Decode login
                    isLogin = try decoder.decode(Bool.self, from: data)
    
                } catch {

                    print("Unable to Decode Login Status: (\(error))")
                }
            }
    
        }

    func signUpWithGoogle() {
        
        guard let clientId = (FirebaseApp.app()?.options.clientID) else { return }
        
        let config = GIDConfiguration(clientID: clientId)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: ApplicationUtility.rootViewController) {
            [self] user, err in
            
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { result, error in
                
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                
                guard let user = result?.user else { return }
                                
                self.signedInStudent = Student(id: "\(UUID())", name: "\(user.displayName ?? "no display name")", email: "\(user.email ?? "no user email")")
                
                do {
                    
                    try self.db.collection("students").document(self.signedInStudent.id).setData(from: self.signedInStudent)
                                    
                } catch {
                    print("error exporting student credentials: \(error)")
                }

                self.isLogin.toggle()
                
            }
        }
    }

}
