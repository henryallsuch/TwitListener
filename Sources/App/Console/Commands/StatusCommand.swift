import Vapor

struct StatusCommand: Command {
    
    var arguments: [CommandArgument] { return [] }
    
    var options: [CommandOption]{ return [] }
    
    var help: [String]{
        return ["Current status of the system"]
    }

    func run(using context: CommandContext) throws -> Future<Void> {
      
        let text: String = "ok"
        context.console.print(text)
        return .done(on: context.container)
    }
}
