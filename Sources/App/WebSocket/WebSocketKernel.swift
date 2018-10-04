import Vapor

class WebSocketKernel {
    
    var server = NIOWebSocketServer.default()
    
    init() throws {
       
       try defaultSockets()
        
    }
    
    public func defaultSockets() throws {
        
        server.get("echo") { ws, req in
            
            ws.onText { ws, text in
                // Simply echo any received text
                ws.send(text)
            }
        }
        
        server.get("chat", String.parameter) {
            
            ws, req in
            let name = try req.parameters.next(String.self)
            ws.send("Welcome, \(name)!")
            
        }
        
    }

    
}
