import Vapor

class HttpKernel {
    
    var routes = EngineRouter.default()
    
    init() throws {
        
        try defaultRoutes()
        
    }
    
    public func defaultRoutes() throws {
        
        let statusController = StatusController()
        try routes.register(collection: statusController)
        
    }

}
