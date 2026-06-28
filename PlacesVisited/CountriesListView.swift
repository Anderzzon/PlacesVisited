import SwiftUI

struct CountriesListView: View {
    var focusSearchOnAppear = false
    @EnvironmentObject var countries: AppViewModel
    @State private var selectedCountry: Country?
    @State private var searchText = ""
    @State private var isSearchPresented = false

    private var filteredCountries: [Country] {
        let all = AppViewModel.Continents.allCases.flatMap { countries.listOfCountries(for: $0) }
        return all.filter { $0.fullName.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        List {
            if searchText.isEmpty {
                ForEach(AppViewModel.Continents.allCases, id: \.self) { continent in
                    let rows = countries.listOfCountries(for: continent)
                    if !rows.isEmpty {
                        Section {
                            ForEach(rows, id: \.objectID) { country in
                                CountryRowView(country: country)
                                    .contentShape(Rectangle())
                                    .onTapGesture { selectedCountry = country }
                            }
                        } header: {
                            HStack {
                                Text(continent.displayName)
                                Spacer()
                                let visited = rows.filter { $0.visited }.count
                                let percent = rows.count > 0 ? Int((Double(visited) / Double(rows.count) * 100).rounded()) : 0
                                Text("\(visited) / \(rows.count) · \(percent)%")
                                    .font(.caption.monospacedDigit())
                            }
                        }
                    }
                }
            } else {
                ForEach(filteredCountries, id: \.objectID) { country in
                    CountryRowView(country: country)
                        .contentShape(Rectangle())
                        .onTapGesture { selectedCountry = country }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Countries")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, isPresented: $isSearchPresented, prompt: "Country name")
        .onAppear {
            if focusSearchOnAppear {
                isSearchPresented = true
            }
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
