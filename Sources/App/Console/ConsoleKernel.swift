import Vapor
import FluentSQLite

class ConsoleKernel {
    
    var commands = CommandConfig.default()
    
    init() {
        
        defaultCommands()
        
        //Fluent
        commands.useFluentCommands()
       
    }
    
    public func defaultCommands(){
        
       commands.use(StatusCommand(), as: "status")
        
    }
    

}
