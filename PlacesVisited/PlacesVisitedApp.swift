import SwiftUI
import CoreData

@main
struct PlacesVisitedApp: App {

    // Single shared controller for all three screens (Countries, Stats, Map)
    @StateObject private var countries: AppViewModel
    // Loads GeoJSON country outlines on a background thread
    @StateObject private var mapDataStore = MapDataStore()

    init() {
        let persistence = PersistenceController.shared
        let viewModel = AppViewModel(context: persistence.container.viewContext)
        viewModel.loadItems()
        // Seed 195 countries on first launch when the database is empty
        if viewModel.totalNumberOfCountries < 1 {
            viewModel.seedDatabase()
            viewModel.loadItems()
        }
        _countries = StateObject(wrappedValue: viewModel)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Make the Core Data context available to any view that needs it
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .environmentObject(countries)
                .environmentObject(mapDataStore)
                .onAppear {
                    // Trigger GeoJSON parsing once the view hierarchy is ready
                    mapDataStore.load(countries: countries)
                }
        }
    }
}
