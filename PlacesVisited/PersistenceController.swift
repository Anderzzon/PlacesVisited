import CoreData

// Owns the Core Data stack. Used by PlacesVisitedApp to create the managed context.
struct PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "PlacesVisited")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
