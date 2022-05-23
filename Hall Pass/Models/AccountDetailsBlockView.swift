//
//  AccountDetailsBlockView.swift
//  Hall Pass
//
//  Created by Ashton George on 4/27/22.
//

import SwiftUI

let placeholderUrl = URL(fileURLWithPath: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimage.shutterstock.com%2Fimage-vector%2Fcaution-exclamation-mark-white-red-260nw-1055269061.jpg&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Ferror&tbnid=NyyEim_FKOz1jM&vet=12ahUKEwiG9vXw9-H2AhXEgHIEHXRDA4AQMygLegUIARDtAQ..i&docid=IZbA2KT5EihWnM&w=260&h=280&q=error&ved=2ahUKEwiG9vXw9-H2AhXEgHIEHXRDA4AQMygLegUIARDtAQ")

struct AccountDetailsBlockView: View {
    
    @EnvironmentObject var signUpVM: SignUpViewModel
    
    @State var imageUrl: URL
        
    func getImage() -> URL {

        let url: URL = (signUpVM.user?.photoURL)!

        print("URL 🔽")
        print(url)
        print("URL 🔼")
        
        return url
    
    }
    
    var body: some View {
        HStack {
            
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .offset(x: -20)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                
                Text(signUpVM.user?.displayName ?? "No name fart")

                
                Text(signUpVM.user?.email ?? "No user email fart")

            }
        }
        .onAppear {
                
            imageUrl = getImage()
            
        }
    }
}

struct AccountDetailsBlockView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailsBlockView(imageUrl: placeholderUrl)
            .previewLayout(.sizeThatFits)
    }
}
