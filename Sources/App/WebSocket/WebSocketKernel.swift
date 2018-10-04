import Vapor

class WebSocketKernel {
    
    var server = NIOWebSocketServer.default()
    
    init() throws {
       
       try defaultSockets()
    
        
    }
    
    public func defaultSockets() throws {
        
        
        let fileWatcher = LocalFileWatcher()
        server.get("listen") { ws, req in
            
            ws.onText { ws, text in
                // Simply echo any received text
                ws.send(text)
            
                fileWatcher.start()
            }
            
            
            
            
            
        }
    
        
    }

    
}
