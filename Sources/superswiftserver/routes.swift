import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }
    
    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("zoo", "green") { req async -> String in // zoo/green
        return "Green animal from the Zoo"
    }
    
    app.get("zoo", ":animal_type") { req async -> String in
        let animalType = req.parameters.get("animal_type") ?? "Unknown"
        return "Hi! \(animalType)"
    }
    
    app.get ("200", "animals", "*") { _ in
        "All other animals from the ZOO"
    }
    
    app.get("zoo", "location", "**") { _ in
        "Unmatched routes"
    }
    
    // Route Groups
    
    let zoo = app.grouped("zoo")
    zoo.get("food") { _ in
        "Food"
    }
    
    zoo.get("humans") { _ in
        "Humans"
    }
    
    zoo.post("animals", ":id") { req in
        let id = req.parameters.get("id") ?? UUID()
        return "Fetching animal with ID \(id)"
    }
    
    // Printing / Debuging
    
    print(app.routes.all)
    
    // ------------------------------------------------------------------------------------
    // MARK: Content (similar to Codable)
    
    app.post("persons") { request in
        let person = try request.content.decode(LegacyPerson.self)
        return "Hello \(person.name)!"
    }
    
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    ContentConfiguration.global.use(decoder: decoder, for: .json)
    
    //    app.post("persons") { request in
    //        let decoder = JSONDecoder()
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyy-MM-dd"
    //        decoder.dateDecodingStrategy = .formatted(dateFormatter)
    //        decoder.keyDecodingStrategy = .convertFromSnakeCase
    //        
    //        let person = try request.content.decode(Person.self, using: decoder)
    //        return "Hello \(person.name)!, your DOB is \(person.dateOfBirth)"
    //    }
    
    // URL Query
    
    app.get("persons") { request in
        let person = try request.query.decode(LegacyPerson.self)
        let name: String = request.query["name"] ?? "Unknown"
        return "Hello from GET \(name) or Greeting \(person.name)"
    }
    
    
    try app.register(collection: PersonsController())
}
