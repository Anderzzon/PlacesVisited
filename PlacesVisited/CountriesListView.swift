import SwiftUI

struct CountriesListView: View {
    @EnvironmentObject var countries: AppViewModel
    @State private var showOnlyNotVisited = false

    var body: some View {
        List {
            ForEach(AppViewModel.Continents.allCases, id: \.self) { continent in
                let rows = showOnlyNotVisited
                    ? countries.listOfCountriesNotVisited(for: continent)
                    : countries.listOfCountries(for: continent)

                if !rows.isEmpty {
                    Section(header: Text(continent.displayName)) {
                        ForEach(rows, id: \.objectID) { country in
                            CountryRowView(country: country, mode: showOnlyNotVisited ? .wantToGo : .visited)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if showOnlyNotVisited {
                                        countries.updateWantToGo(country: country, index: nil)
                                    } else {
                                        countries.updateVisit(country: country, index: nil)
                                    }
                                    country.updateMap = true
                                    countries.loadItems()
                                }
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Countries")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Picker("", selection: $showOnlyNotVisited) {
                    Text("Visited").tag(false)
                    Text("Want to go").tag(true)
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 220)
            }
        }
        .onAppear {
            countries.loadItems()
        }
    }
}

extension AppViewModel.Continents {
    var displayName: String {
        switch self {
        case .Europe: return "Europe"
        case .Asia: return "Asia"
        case .NorthAmerica: return "North America"
        case .Africa: return "Africa"
        case .SouthAmerica: return "South America"
        case .Oceania: return "Oceania (Australia)"
        }
    }
}
