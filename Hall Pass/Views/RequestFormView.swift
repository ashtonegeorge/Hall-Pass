//
//  RequestFormView.swift
//  Hall Pass
//
//  Created by Ashton George on 2/11/22.
//

import SwiftUI

struct RequestFormView: View {
    
    @EnvironmentObject var requestManager: RequestManager
    @EnvironmentObject var signUpVM: SignUpViewModel

    @State var showingRequestSummary = false
    
    @State var request: Request
    
    @State var courseId: String
    @State var courseName: String
            
    var body: some View {
        
            GeometryReader { geo in
                
                Text(courseName)
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .frame(width: geo.size.width, alignment: .center)
                    .offset(y: 40)
                                    
                    List {
                        
                        ZStack(alignment: .leading) {
                            
                            if request.reason.isEmpty {
                                Text("Where are you going? ")
                                    .foregroundColor(.gray)
                                    .offset(x: 5, y: -30)
                                    .frame(alignment: .top)
                                
                            }
                            
                            TextEditor(text: $request.reason)
                                .lineLimit(3)
                                .frame(height: 100)

                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .offset(y: 100)
                    .cornerRadius(10)
                        
                    Button(action: {
                        
                        request.id = "\(UUID())"
                        
                        request.destinationId = courseId
                        
                        request.name = signUpVM.user?.displayName ?? "No user display name sus"
                        
                        requestManager.sendRequest(request: request, courseId: courseId)
                        showingRequestSummary.toggle()
                                                    
                        }, label: {
                                
                            SubmitButtonView()
                    
                        })
                        .frame(width: geo.size.width, height: geo.size.height)
                        .offset(y:100)
                        .sheet(isPresented: $showingRequestSummary) {
                            RequestSummary(request: Request(id: request.id, name: request.name, reason: request.reason, destinationId: request.destinationId), courseId: courseId)
//                                .interactiveDismissDisabled()
                                .onAppear() {
                                    
                                    request.reason = ""

                                }
                    
                        }
                            

                    
                }
                .padding()

        }
    }



struct RequestFormView_Previews: PreviewProvider {
    static var previews: some View {
        RequestFormView(request: Request(id: "", name: "", reason: "", destinationId: ""), courseId: "", courseName: "stink")
            .environmentObject(SignUpViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
