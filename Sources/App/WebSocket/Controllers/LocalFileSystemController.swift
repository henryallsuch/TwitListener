
import Vapor
import ShellOut

class LocalFileSystemController : WebsocketCollection  {
    
    let directoryPath : String = "/Users/saoirse/Documents/Testing/"
    
    var fileWatcher : LocalFileWatcher? = nil
    var currentWebSocket : WebSocket?
    
    func boot(server: NIOWebSocketServer) throws {
        
        // wsta ws://localhost:8080/listen
        server.get("/listen", use: fileSystemEventWebsocketInit)
        
    }
    
    func fileSystemEventWebsocketInit(webSocket: WebSocket, request :Request) throws -> ()  {
        
        //fileWatcher = LocalFileWatcher(URL(fileURLWithPath:directoryPath + "test.json"))
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
        
        do {
            
            let output = try shellOut(to: "git status --porcelain=v2 --branch", at: self.directoryPath)
            currentWebSocket?.send(output)
            
           // let diffOutput = try shellOut(to: "git diff test.json", at: self.directoryPath)
           // currentWebSocket?.send(diffOutput)
            
        } catch {
            let error = error as! ShellOutError
            print(error.message)
            print(error.output)
        }
        
        
    }
    
}
