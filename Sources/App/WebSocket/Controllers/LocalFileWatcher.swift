

import Foundation
import KZFileWatchers

class LocalFileWatcher {
    
    private var fileWatcher: FileWatcherProtocol?
    
    init() {
        
    }
    
    func start(){
        
        let path = "/Users/saoirse/Desktop/test/file.txt"
        
        if !FileManager.default.fileExists(atPath: path) {
            
            let url = URL(fileURLWithPath: path)
            try? "Hello daemon world!".data(using: .utf8)?.write(to: url, options: .atomic)
        }
        
        fileWatcher = FileWatcher.Local(path: path)
        
        try! fileWatcher?.start() { result in
            switch result {
            case .noChanges:
                print("no changes")
                break
            case .updated(let data):
                let text = String(data: data, encoding: .utf8)
                print(text!)
            }
        }
        
    }
    
}
