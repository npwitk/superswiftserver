import Vapor
import Fluent
import FluentSQLiteDriver

// configures your application
public func configure(_ app: Application) async throws {
    app.databases.use(.sqlite(.memory), as: .sqlite)
    app.migrations.add(CreatePersonMigration())
    // TODO: DO not forget  to run the migrations
    try await app.autoMigrate()
    
    
    // Suppose, we don't run the first migration
    // SELECT * FROM persons; table not found!!
    
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app)
    
}
