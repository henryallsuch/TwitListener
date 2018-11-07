import Foundation

class LocalFileWatcher {

    private let queueLabel :String = "io.twit.listener"
    private let queue: DispatchQueue
    private var watchLocationUrl : NSString
    private var watcher: DispatchSourceFileSystemObject?
    
    init(_ url: URL) {
        
        guard FileManager.default.fileExists(atPath: url.path) == true else {
           
            fatalError("\(url.path) File does not exist")
        
        }
        
        watchLocationUrl = (url.path as NSString)
        
        self.queue = DispatchQueue(label: queueLabel)
    }
    
    func start(closure: @escaping () -> Void) {
        
        let fileDescriptor = open(watchLocationUrl.fileSystemRepresentation, O_EVTONLY)
        
         guard fileDescriptor != -1 else {
            
             fatalError(String(utf8String: strerror(errno)) ?? "Unknown error code")
            
        }
        
        let watcher = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fileDescriptor,
            eventMask: .all,
            queue: self.queue
        )
        
        watcher.setEventHandler {
           // [weak self] in
            print("File system event");
            closure()
        }
        
        watcher.setCancelHandler() {
            print("stopped watching \(self.watchLocationUrl)");
            close(fileDescriptor)
        }
        
        watcher.resume()
        print("started watching \(watchLocationUrl)");
        
        self.watcher = watcher
    }
    
    func stop(){
        watcher?.cancel()
    }
    
}
