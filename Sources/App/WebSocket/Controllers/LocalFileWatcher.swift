

import Foundation
import Vapor
import FilesProvider

class LocalFileWatcher {
    
    typealias ClosureType = (_ responseData:String?) throws -> Void
    let documentsProvider = LocalFileProvider()
    
    func start( onChange changeCallback : @escaping ClosureType){
        
        let path = "/Users/saoirse/Desktop/test/"
        
        if !FileManager.default.fileExists(atPath: path) {
            
            let url = URL(fileURLWithPath: path)
            try? "Hello daemon world!".data(using: .utf8)?.write(to: url, options: .atomic)
        }
        
        documentsProvider.registerNotifcation(path: path, eventHandler: {  

            do {
                
                try changeCallback("files changed")

//                switch result {
//                case .noChanges:
//                    print("no cahnges")
//                    break
//                case .updated(let data):
//                    let text = String(data: data, encoding: .utf8)
//
//                    print("tried callback")
//                }


            } catch {
                print("failed to call success callback")
                print(error)

            }
            
       })
        
    }
    
}
