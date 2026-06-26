import SwiftUI

struct WorldMapView: View {
    @EnvironmentObject var countries: AppViewModel
    @EnvironmentObject var mapDataStore: MapDataStore
    @State private var selectedCountry: Country?
    @State private var showingDialog = false

    var body: some View {
        MapViewRepresentable(selectedCountry: $selectedCountry, showingDialog: $showingDialog)
            .ignoresSafeArea()
            .confirmationDialog(
                selectedCountry.map { "Update \($0.fullName)" } ?? "",
                isPresented: $showingDialog,
                titleVisibility: .visible
            ) {
                Button("Visit") {
                    if let country = selectedCountry {
                        countries.updateVisit(country: country, index: nil)
                        country.updateMap = true
                        countries.loadItems()
                    }
                }
                Button("Want to go") {
                    if let country = selectedCountry {
                        countries.updateWantToGo(country: country, index: nil)
                        country.updateMap = true
                        countries.loadItems()
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
    }
}
