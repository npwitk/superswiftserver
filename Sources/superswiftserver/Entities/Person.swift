//
//  Person.swift
//  superswiftserver
//
//  Created by Nonprawich I. on 1/1/26.
//

import Fluent
import Foundation

final class Person: Model, @unchecked Sendable {
    static let schema: String = "persons"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @OptionalField(key: "date_of_birth")
    var dateOfBirth: Date?
    
    @OptionalEnum(key: "eye_color")
    var eyeColor: EyeColor?
    
//    @Boolean(key: "is_active", format: .onOff) YOU CAN CONFIGURE THE FORMAT
    @Boolean(key: "is_active")
    var isActive: Bool
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .create)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .create)
    var deletedAt: Date?
    
    init() { }
    
    init(
        id: UUID? = nil,
        name: String,
        dateOfBirth: Date? = nil,
        eyeColor: EyeColor? = nil,
        isActive: Bool = true
    ) {
        self.id = id
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.eyeColor = eyeColor
        self.isActive = isActive
    }
    
}

enum EyeColor: String, Codable {
    case blue, black, other
}
