import Foundation
import Vapor

class LocalFileWatcher {

    private var path : NSString
    private let queue: DispatchQueue
    private var source: DispatchSourceFileSystemObject?
    
    init(_ url: URL) {
        
        guard FileManager.default.fileExists(atPath: url.path) == true else {
           
            fatalError("\(url.path) File does not exist")
        
        }
        
        path = (url.path as NSString)
        
        self.queue = DispatchQueue(label: "io.twit.listener")
    }
    
    func start(closure: @escaping () -> Void) {
        // We can only convert an NSString into a file system representation
     
        let fileSystemRepresentation = path.fileSystemRepresentation
        
        // Obtain a descriptor from the file system
        let fileDescriptor = open(fileSystemRepresentation, O_EVTONLY)
        
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
            [weak self] in
            self?.printTime(withComment: "File event");
            closure()
        }
        

        source.setCancelHandler() {
            close(fileDescriptor)
        }
        
        
       // source.setEventHandler(handler: DispatchWorkItem)
        source.resume()
        self.printTime(withComment: "Resuming Watch on \(path)");
        
        self.source = source
    }
    
    func printTime(withComment comment: String){
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        print(comment + ": " + formatter.string(from: date))
    }
}
