//
//  RequestSummary.swift
//  Hall Pass
//
//  Created by Ashton George on 2/11/22.
//

import SwiftUI

struct RequestSummary: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var requestManager: RequestManager

    @State var request: Request
    @State var courseId: String
    @State var matchingCourse: String = "placeholderMatchingCourse"
    @State private var backgroundColor: UIColor = .white
    @State private var timeOut: String = "placeholderTimeOut"
    @State private var timeIn: String = "placeholderTimeIn"
    @State private var dateOpacity: Double = 0.0
    
    // self.timeOut = timeOut
    // self.timeIn = timeOut.addingTimeInterval(5 * 60)
        
    func getTimeOut(date: Date) -> String {
        
        return date.formatted(.dateTime.hour().minute()) as String
        
    }
    
    func getTimeIn(date: Date) -> String {
        
        date.addingTimeInterval(5 * 60)
        
        return date.formatted(.dateTime.hour().minute()) as String
        
        
    }

    func findMatchingCourse(id: String) -> String {
            
        for course in requestManager.courses {
        
            if id == course.courseId {
                
                matchingCourse = course.courseName
                
            }
            
        }
        
        return matchingCourse
                    
    }
    
    var body: some View {
        
        
        ZStack {
            
            Rectangle()
                .foregroundColor(Color(backgroundColor))
            
            Rectangle()
                .frame(width: 600, height: 630)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack {
                
                Button {
                    withAnimation {
                        backgroundColor = .green
                        dateOpacity = 100
                    }
                    
                    
                    timeOut = getTimeOut(date: Date())
                    timeIn = getTimeIn(date: Date())
                    
                    
                } label: {
                    Text("GOOOOOO")
                }
                
                Button {
                    withAnimation {
                        backgroundColor = .red
                    }
                } label : {
                    Text("BADDDDD")
                }

                
                //to display whether the request was approved or disapproved, turn the whole background square green or red with animation

                //add init checker in sheet to turn green when teacher approves request. also on approval set timein and timeout
                            
                Text("Request sent to class \(matchingCourse)" as String)
                    .font(.largeTitle)
                    .padding()
                
                Text("Time out:  " + timeOut)
                    .font(.largeTitle)
                    .opacity(dateOpacity)
                    .padding()
                
                Text("Time in:   " + timeIn)
                    .font(.largeTitle)
                    .opacity(dateOpacity)
                    .padding()
                
                
                Button(action: {
                    
                    requestManager.deleteRequest(requestToDelete: request)
                    dismiss()
                    
                }, label: {
                    Text("Cancel request")
                })


                
            }
            .onAppear() {
                
                matchingCourse = findMatchingCourse(id: request.destinationId)
                
            }
            
        }
    }
}

struct RequestSummary_Previews: PreviewProvider {
    static var previews: some View {
        RequestSummary(request: Request(id: "", name: "", reason: "", destinationId: ""), courseId: "")
            .environmentObject(RequestManager())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

