import Foundation
import MapKit

@MainActor
class MapDataStore: ObservableObject {
    @Published var overlayDict: [String: CountryGeo] = [:]
    @Published var isReady = false

    func load(countries: AppViewModel) {
        Task {
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

            for continent in AppViewModel.Continents.allCases {
                for country in countries.listOfCountries(for: continent) {
                    var identifier = ""
                    if country.visited { identifier = "visited" }
                    else if country.wantToGo { identifier = "wantToGo" }
                    newOverlayDict[country.shortName]?.polygons.forEach { $0.identifier = identifier }
                }
            }

            self.overlayDict = newOverlayDict
            self.isReady = true
        }
    }
}
