import Foundation

class LocalFileWatcher {

    private let queueLabel :String = "io.twit.listener"
    private var path : NSString
    private let queue: DispatchQueue
    private var source: DispatchSourceFileSystemObject?
    
    init(_ url: URL) {
        
        guard FileManager.default.fileExists(atPath: url.path) == true else {
           
            fatalError("\(url.path) File does not exist")
        
        }
        
        path = (url.path as NSString)
        
        self.queue = DispatchQueue(label: queueLabel)
    }
    
    func start(closure: @escaping () -> Void) {
        
        let fileDescriptor = open(path.fileSystemRepresentation, O_EVTONLY)
        
         guard fileDescriptor != -1 else {
            
             fatalError(String(utf8String: strerror(errno)) ?? "Unknown error code")
            
        }
        
        // Create our dispatch source
        let source = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fileDescriptor,
            eventMask: .all,
            queue: self.queue
        )
        
        
        source.setEventHandler {
           // [weak self] in
            print("File system event");
            closure()
        }
        

        source.setCancelHandler() {
            print("stopped watching \(self.path)");
            close(fileDescriptor)
        }
        
        source.resume()
        print("started watching \(path)");
        
        self.source = source
    }
    
    func stop(){
        source?.cancel()
    }
    
}
