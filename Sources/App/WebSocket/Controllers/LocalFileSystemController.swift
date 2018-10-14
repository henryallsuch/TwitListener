
import Vapor

class LocalFileSystemController : WebsocketCollection  {
    
    let directoryPath : String = "/Users/saoirse/Documents/Testing/"
    
    var fileWatcher : LocalFileWatcher? = nil
    var currentWebSocket : WebSocket?
    
    func boot(server: NIOWebSocketServer) throws {
        
        // wsta ws://localhost:8080/listen
        server.get("listen", use: fileSystemEventWebsocketInit)
        
    }
    
    func fileSystemEventWebsocketInit(webSocket: WebSocket, request :Request) throws -> ()  {
        
        fileWatcher = LocalFileWatcher(URL(fileURLWithPath:directoryPath))
        fileWatcher?.start(closure: self.fileSystemEventHandler)
        
        currentWebSocket = webSocket
        
        webSocket.onText(self.onText)
        
    }
    
    func onText(webSocket: WebSocket, text: String) -> (){
        
        if(text == "close"){
            
            self.close()
            
        } else {
            print(text)
        }
        
    }
    
    func close(){
        
        currentWebSocket?.close()
        fileWatcher?.stop()
    }
    
    
    func fileSystemEventHandler(){
        
        currentWebSocket?.send("File system event")
        
    }
    
}
