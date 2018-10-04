import Vapor

class ConsoleKernel {
    
    var commands = CommandConfig.default()
    
    init() {
        
        defaultCommands()
        commands.useFluentCommands()
       
    }
    
    public func defaultCommands(){
        
       commands.use(StatusCommand(), as: "status")
        
    }
    

}
