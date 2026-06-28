import Foundation
import MapKit

@MainActor
class MapDataStore: ObservableObject {
    @Published var overlayDict: [String: CountryGeo] = [:]
    @Published var isReady = false

    func load(countries: AppViewModel) {
        // Snapshot visited/wantToGo state on the main actor before going off-thread
        var visited = Set<String>()
        var wantToGo = Set<String>()
        for continent in AppViewModel.Continents.allCases {
            for country in countries.listOfCountries(for: continent) {
                if country.visited { visited.insert(country.shortName) }
                else if country.wantToGo { wantToGo.insert(country.shortName) }
            }
        }

        Task.detached(priority: .userInitiated) {
            var newOverlayDict = [String: CountryGeo]()

            if let path = Bundle.main.path(forResource: "allCountries", ofType: "json"),
               let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
               let json = (try? JSONSerialization.jsonObject(with: data)) as? [[String: Any]] {
                for co in json {
                    let country = CountryGeo(json: co)
                    if let iso = country.isoA3 {
                        newOverlayDict[iso] = country
                    }
                }
            }

            for (iso, geo) in newOverlayDict {
                let identifier = visited.contains(iso) ? "visited" : wantToGo.contains(iso) ? "wantToGo" : ""
                geo.polygons.forEach { $0.identifier = identifier }
            }

            await MainActor.run {
                self.overlayDict = newOverlayDict
                self.isReady = true
            }
        }
    }
}
