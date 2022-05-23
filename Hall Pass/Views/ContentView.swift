//
//  ContentView.swift
//  Hall Pass
//
//  Created by Ashton George on 2/11/22.
//

import SwiftUI

//let placeholderUrl = URL(fileURLWithPath: "https://www.google.com/imgres?imgurl=https%3A%2F%2Fimage.shutterstock.com%2Fimage-vector%2Fcaution-exclamation-mark-white-red-260nw-1055269061.jpg&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Ferror&tbnid=NyyEim_FKOz1jM&vet=12ahUKEwiG9vXw9-H2AhXEgHIEHXRDA4AQMygLegUIARDtAQ..i&docid=IZbA2KT5EihWnM&w=260&h=280&q=error&ved=2ahUKEwiG9vXw9-H2AhXEgHIEHXRDA4AQMygLegUIARDtAQ")

let fitnessGram:String = "The FitnessGram™ Pacer Test is a multistage aerobic capacity test that progressively gets more difficult as it continues. The 20 meter pacer test will begin in 30 seconds. Line up at the start. The running speed starts slowly, but gets faster each minute after you hear this signal. [beep] A single lap should be completed each time you hear this sound. [ding] Remember to run in a straight line, and run as long as possible. The second time you fail to complete a lap before the sound, your test is over. The test will begin on the word start. On your mark, get ready, start."

extension String {
    
    func loadImage() -> UIImage {
        
        do {
            
            guard let url = URL(string: self) else {
               
                return UIImage()
            
            }
            
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
            
            
        } catch {
            
            
        }
        
        return UIImage()
        
    }
    
}


struct CourseCell: View {
    
    @StateObject private var requestManager = RequestManager()
    @EnvironmentObject var signUpVM: SignUpViewModel
    
// firestore query property wrapper???
    
    let course: Course

    var body: some View {
        VStack {
            NavigationLink {
                RequestFormView(request: Request(id: "", name: "", reason: "", destinationId: ""), courseId: "\(course.courseId)", courseName: course.courseName)
            } label: {
                Text(course.courseName)
                    .lineLimit(1)
            }
            .font(.system(size: 30))
            
            ForEach(requestManager.teachers){ Teacher in
                if Teacher.courseId == course.courseId {
                    Text(Teacher.name)
                }
            }
            .frame(alignment: .leading)
            
        }
        .frame(width: 250, height: 100, alignment: .center)
        .onAppear {
            requestManager.getTeachers()
            }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var requestManager: RequestManager
    @EnvironmentObject var signUpVM: SignUpViewModel
    @Environment (\.scenePhase) var scenePhase
            
    var body: some View {
        
        VStack {
            
            if signUpVM.isLogin == false {

                SignInBlockView()
                
            }
            
            if signUpVM.isLogin {
                

                ZStack {
                    
                    NavigationView {
                        
                        VStack(alignment: .center) {
                                
                                    List {
                                                                                
                                        ForEach (requestManager.courses){ Course in
                                            
                                            ZStack {
                                                Rectangle()
                                                    .frame(width: 250, height: 100)
                                                    .foregroundColor(.white)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                                    .padding()

                                                CourseCell(course: Course)
                                            }
                                            
                                    }
                                }
                                .foregroundColor(.blue)
                                .navigationTitle("Course Select")
                                    
                                }
                            }
                        .onAppear {
                            requestManager.getCourses()
                            }
                        }
                
                    AccountDetailsBlockView(imageUrl: placeholderUrl)
                    .environmentObject(SignUpViewModel())
                        .offset(x: 300, y: -725)
                        .ignoresSafeArea(.keyboard, edges: .all)

                    }
                }
                .frame(height: 850)
                .offset(y: 20)
                .onChange(of: scenePhase) { newPhase in
                    
                    if newPhase == .active {
                        
                        signUpVM.decodeSignIn()
                        
                    }
                    
                    if newPhase == .background {
                        
                        signUpVM.encodeSignIn()
                        
                    }
                }
            }

        }


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(SignUpViewModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
