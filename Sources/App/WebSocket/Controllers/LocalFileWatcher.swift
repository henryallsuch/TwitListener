

import Foundation
import KZFileWatchers


class LocalFileWatcher {
    
    private var fileWatcher: FileWatcherProtocol?
    typealias ClosureType = (_ responseData:String?) throws -> Void
    
    init() {
        
    }
    
    func start( onChange changeCallback : @escaping ClosureType){
        
        let path = "/Users/saoirse/Desktop/test/file.txt"
        
        if !FileManager.default.fileExists(atPath: path) {
            
            let url = URL(fileURLWithPath: path)
            try? "Hello daemon world!".data(using: .utf8)?.write(to: url, options: .atomic)
        }
        
        fileWatcher = FileWatcher.Local(path: path)
        
    
         do {
            
        try fileWatcher?.start(closure: { result in
            
            
            do {
                
                switch result {
                case .noChanges:
                    print("no cahnges")
                    break
                case .updated(let data):
                    let text = String(data: data, encoding: .utf8)
                    try changeCallback(text!)
                    print("tried callback")
                }
                
                
            } catch {
                print("failed to call success callback")
                print(error)
                
            }
            
        })
        
    } catch {
        print("failed to start listening")
        print(error)
    
    }
        
    }
    
}
