import Vapor

class WebSocketKernel {
    
    var server = NIOWebSocketServer.default()
    let fileWatcher = LocalFileWatcher(URL(fileURLWithPath:"/Users/saoirse/Documents/Testing/"))
    var currentWebSocket : WebSocket?
    
    init() throws {
       
       try defaultSockets()
        
        fileWatcher.start(closure: self.handleFileChange)
        
    }
    
    public func defaultSockets() throws {
        
        
        server.get("listen") { webSocket, request in
            
            self.currentWebSocket = webSocket
            
            webSocket.onText { webSocket, text in

                self.printTime(withComment: text)

            }
            
            
    
        }
    
        
    }
    
    func printTime(withComment comment: String){
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        print(comment + ": " + formatter.string(from: date))
    }
    
    func handleFileChange(){
        
        currentWebSocket?.send("file change")
        
    }

    
}
