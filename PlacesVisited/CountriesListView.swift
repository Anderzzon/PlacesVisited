import SwiftUI

struct CountriesListView: View {
    @EnvironmentObject var countries: AppViewModel
    @State private var selectedCountry: Country?

    var body: some View {
        List {
            ForEach(AppViewModel.Continents.allCases, id: \.self) { continent in
                let rows = countries.listOfCountries(for: continent)
                if !rows.isEmpty {
                    Section(header: Text(continent.displayName)) {
                        ForEach(rows, id: \.objectID) { country in
                            CountryRowView(country: country)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedCountry = country
                                }
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Countries")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            countries.loadItems()
        }
        .sheet(item: $selectedCountry) { country in
            CountryEditSheet(country: country)
                .environmentObject(countries)
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
