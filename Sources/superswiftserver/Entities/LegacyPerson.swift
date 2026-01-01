//
//  Person.swift
//  superswiftserver
//
//  Created by Nonprawich I. on 28/12/25.
//

import Vapor

struct LegacyPerson: Content, Identifiable {
    let id: UUID
    let name: String
    let dateOfBirth: Date?
}

extension LegacyPerson {
    init(name: String, dateOfBirth: Date?) {
        id = UUID()
        self.name = name
        self.dateOfBirth = dateOfBirth
    }
}
