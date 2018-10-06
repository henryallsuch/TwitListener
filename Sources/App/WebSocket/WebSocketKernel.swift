import Vapor
import KZFileWatchers

class WebSocketKernel {
    
    var server = NIOWebSocketServer.default()
    let fileWatcher = LocalFileWatcher()
    
    init() throws {
       
       try defaultSockets()
    
        
    }
    
    public func defaultSockets() throws {
        
        
        
        server.get("listen") { ws, req in
            
//            ws.onText { ws, text in
//
//
//
//            }
//
            
         
                
                self.fileWatcher.start(onChange: {
                    
                    (result : String?) in
                    
                    ws.send("File Change")
                    
                    ws.send(result!)


                })
            
        
    
        }
    
        
    }

    
}
