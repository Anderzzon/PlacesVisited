import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Countries", systemImage: "list.bullet", value: 0) {
                NavigationStack {
                    CountriesListView()
                }
            }
            Tab("Map", systemImage: "map", value: 1) {
                WorldMapView()
            }
            Tab("Stats", systemImage: "chart.pie", value: 2) {
                NavigationStack {
                    StatsView()
                }
            }
            Tab(value: 3, role: .search) {
                NavigationStack {
                    CountriesListView(focusSearchOnAppear: true)
                }
            }
        }
        .accentColor(.orange)
    }
}
