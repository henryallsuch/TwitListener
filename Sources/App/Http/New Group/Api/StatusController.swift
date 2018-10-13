
import Vapor

class StatusController : RouteCollection {
    func boot(router: Router) throws {
        
        let statusRoutes = router.grouped("api")
        statusRoutes.get("status",use: getStatusHandler)
        
    }
        
    func getStatusHandler(_ req: Request) throws -> String {
        return "ok!"
    }
    
}
