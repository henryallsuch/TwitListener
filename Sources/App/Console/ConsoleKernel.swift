import Vapor

class ConsoleKernel {
    
    var config = CommandConfig.default()
    
    init() {
        
        config.useFluentCommands()
        addCustomCommands()
        
    }
    
    public func addCustomCommands(){
        
       config.use(StatusCommand(), as: "status")
        
    }
    
    public func commandsConfig() -> CommandConfig {
        return self.config
    }

}
