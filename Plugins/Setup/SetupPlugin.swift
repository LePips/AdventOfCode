import Foundation
import PackagePlugin

@main
struct Plugin: CommandPlugin {
    
    struct SetupError: Error {
        
        let m: String
        
        var localizedDescription: String { m }
        
        static let UnexpectedArguments = SetupError(m: "Unexpected number of arguments")
    }
    
    func performCommand(context: PluginContext, arguments: [String]) throws {
        
        guard arguments.count >= 2, arguments.count < 4 else {
            printUsage()
            throw SetupError.UnexpectedArguments
        }
        
        var args = ArgumentExtractor(arguments)
    }
    
    func printUsage() {
        let message = """
        USAGE: setup.swift <year> [sample]

        SUBCOMMANDS:
          sample              Create sample files for days in the year
        """
        print(message)
    }
}
