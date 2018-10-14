import Vapor

class WebSocketKernel {
    
    var server = NIOWebSocketServer.default()
    
    init() throws {
       
       try defaultSockets()

    }
    
    public func defaultSockets() throws {
        
        let localfileSystemController = LocalFileSystemController()
        
        try server.register(collection: localfileSystemController)
        
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
