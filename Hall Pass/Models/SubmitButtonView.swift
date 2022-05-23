//
//  SubmitButtonView.swift
//  Hall Pass
//
//  Created by Ashton George on 5/6/22.
//

import SwiftUI

struct SubmitButtonView: View {
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 125, height: 75)
                .foregroundColor(.blue)
            
            Text("Send")
                .font(.largeTitle)
                .foregroundColor(.white)
            
        }
        .padding()
        
        
    }
}

struct SubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButtonView()
            .previewLayout(.sizeThatFits)
    }
}
