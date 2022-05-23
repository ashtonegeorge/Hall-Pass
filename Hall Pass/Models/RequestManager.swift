//
//  RequestManager.swift
//  Hall Pass
//
//  Created by Ashton George on 2/11/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class RequestManager: ObservableObject {
    @Published private(set) var requests: [Request] = []
    @Published private(set) var teachers: [Teacher] = []
    @Published var courses: [Course] = []
    
    private var db = Firestore.firestore()


    func getCourses() {
        
        db.collection("courses").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("error fetching courses! \(String(describing: error))")
                return
                }
            
            self.courses = documents.map { (queryDocumentSnapshot) -> Course in
             
                let data = queryDocumentSnapshot.data()
                let name = data["courseName"] as? String ?? "error"
                let courseId = data["courseId"] as? String ?? "error"
                let id = data["id"] as? String ?? "error"
                
                return Course(courseId: courseId, courseName: name, id: id)
                
            }
        }
    }

    func getTeachers() {
                
        db.collection("teachers").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching teachers! \(String(describing: error))")
                return
            }
            
            self.teachers = documents.map { (queryDocumentSnapshot) -> Teacher in
             
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? "error"
                let courseId = data["courseId"] as? String ?? "error"
                let id = data["id"] as? String ?? "error"
                let email = data["email"] as? String ?? "error"
                
                return Teacher(id: id, name: name, courseId: courseId, email: email)
                
            }
        }
    }

    func deleteRequest(requestToDelete: Request) {
        
        print(requestToDelete.id)
        
        db.collection("requests").document("\(requestToDelete.id)").delete()
            
    }
    
    func sendRequest(request: Request, courseId: String) {
        
        //MARK: trying to assign destinationid as courseid
        
        do {
                
            try db.collection("requests").document("\(request.id)").setData(from: request)
            
        } catch {
            
            print("error loading the jawnson")
            
        }
    }
}
