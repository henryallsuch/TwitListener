import Vapor

class WebSocketKernel {
    
    var server = NIOWebSocketServer.default()
    
    init() throws {
       
       try defaultSockets()

    }
    
    public func defaultSockets() throws {
        
        let fileEventController = FileEventController()
        
        try server.register(collection: fileEventController)
        
    
    }
    
}


public protocol WebsocketCollection {
    func boot(server: NIOWebSocketServer) throws
}

extension NIOWebSocketServer {
    public func register(collection: WebsocketCollection) throws {
        
        try collection.boot(server: self)
        
        
    }
}
