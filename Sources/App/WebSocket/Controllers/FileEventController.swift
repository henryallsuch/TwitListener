
import Vapor

class FileEventController : WebsocketCollection  {

    let fileWatcher = LocalFileWatcher(URL(fileURLWithPath:"/Users/saoirse/Documents/Testing/"))
    var currentWebSocket : WebSocket?
    
    func boot(server: NIOWebSocketServer) throws {
        server.get("events", use: websocketHandler)
    }
    
    func websocketHandler(webSocket: WebSocket, request :Request) throws -> ()  {
        
        fileWatcher.start(closure: self.handleFileChange)
        
        currentWebSocket = webSocket
        
        webSocket.onText { webSocket, text in
            
            print(text)
            // self.printTime(withComment: text)
            
        }
        
        
    }
    
    func handleFileChange(){
        
        currentWebSocket?.send("file event")
        
    }
    
}
