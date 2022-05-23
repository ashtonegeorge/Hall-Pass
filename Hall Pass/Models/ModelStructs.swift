//
//  Request.swift
//  Hall Pass
//
//  Created by Ashton George on 2/11/22.
//

import Foundation

struct Request: Identifiable, Codable {
    
    var id: String
    var name: String
    var reason: String
    var destinationId: String

        
    init(id: String, name: String, reason: String, destinationId: String) {
        
        self.id = id
        self.name = name
        self.reason = reason
        self.destinationId = destinationId
        
    }
}

struct Course: Identifiable, Codable {
    
    var courseId: String
    let courseName: String
    let id: String
    
}

struct Teacher: Identifiable, Codable {
        
    var id: String
    var name: String
    var courseId: String
    var email: String
    
}

struct Student: Identifiable, Codable {
    
    var id: String
    var name: String
    var email: String
    
}
