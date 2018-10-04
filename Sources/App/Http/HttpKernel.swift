import Vapor

class HttpKernel {
    
    let router = EngineRouter.default()
    
    init() throws {
        
        try routes()
        
    }
    
    public func routes() throws {
        
        // Basic "It works" example
        router.get { req in
            return "It works!"
        }
        
        // Basic "Hello, world!" example
        router.get("hello") { req in
            return "Hello, world!"
        }
        
        // Example of configuring a controller
        //let todoController = TodoController()
        // router.get("todos", use: todoController.index)
        // router.post("todos", use: todoController.create)
        // router.delete("todos", Todo.parameter, use: todoController.delete)
    }
    
    public func routerConfig() -> EngineRouter {
        return self.router
    }

}
