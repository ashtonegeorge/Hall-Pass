//
//  SignInBlockView.swift
//  Hall Pass
//
//  Created by Ashton George on 3/23/22.
//

import SwiftUI

struct SignInBlockView: View {
    
    @EnvironmentObject var signUpVM: SignUpViewModel
    
    var body: some View {
        
        HStack {
         
            Button {
                signUpVM.signUpWithGoogle()
            } label: {
                
                Image("goog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                Text("Sign up with Google")
                    .font(.headline)
                
            }
        }
    }
}

struct SignInBlockView_Previews: PreviewProvider {
    static var previews: some View {
        SignInBlockView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
