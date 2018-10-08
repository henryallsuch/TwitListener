import FluentSQLite
import Vapor

public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
   
    try services.register(FluentSQLiteProvider())

    let http = try HttpKernel()
    services.register(http.routes, as: Router.self)

    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    let sqlite = try SQLiteDatabase(storage: .memory)

    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)

    let migrations = MigrationConfig()
    //migrations.add(model: Todo.self, database: .sqlite)
    services.register(migrations)
    
    let console = ConsoleKernel()
    services.register(console.commands)
    
    let sockets = try WebSocketKernel()
    services.register(sockets.server, as: WebSocketServer.self)
    
}
