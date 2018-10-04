import Vapor

class HttpKernel {
    
    var routes = EngineRouter.default()
    
    init() throws {
        
        try defaultRoutes()
        
    }
    
    public func defaultRoutes() throws {
        
        // Basic "It works" example
        routes.get { req in
            return "It works!"
        }
        
        // Basic "Hello, world!" example
        routes.get("hello") { req in
            return "Hello, world!"
        }
        
        // Example of configuring a controller
        //let todoController = TodoController()
        // router.get("todos", use: todoController.index)
        // router.post("todos", use: todoController.create)
        // router.delete("todos", Todo.parameter, use: todoController.delete)
    }

}
