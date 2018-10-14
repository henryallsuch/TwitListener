
import Vapor

class LocalFileSystemController : WebsocketCollection  {

    var fileWatcher : LocalFileWatcher? = nil
    
    var currentWebSocket : WebSocket?
    
    func boot(server: NIOWebSocketServer) throws {
        
        server.get("listen", use: fileSystemEventWebsocketInit)
        
    }
    
    func fileSystemEventWebsocketInit(webSocket: WebSocket, request :Request) throws -> ()  {
        
        fileWatcher = LocalFileWatcher(URL(fileURLWithPath:"/Users/saoirse/Documents/Testing/"))
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
        
        currentWebSocket?.send("File System Event")
        
    }
    
}
