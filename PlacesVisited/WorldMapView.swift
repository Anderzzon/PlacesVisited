import SwiftUI

struct WorldMapView: View {
    @EnvironmentObject var countries: AppViewModel
    @EnvironmentObject var mapDataStore: MapDataStore
    @State private var selectedCountry: Country?

    var body: some View {
        MapViewRepresentable(selectedCountry: $selectedCountry)
            .ignoresSafeArea()
            .sheet(item: $selectedCountry) { country in
                CountryEditSheet(country: country)
                    .environmentObject(countries)
            }
    }
}
