import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Countries", systemImage: "list.bullet") {
                NavigationStack {
                    CountriesListView()
                }
            }
            Tab("Stats", systemImage: "chart.pie") {
                NavigationStack {
                    StatsView()
                }
            }
            Tab("Map", systemImage: "map") {
                WorldMapView()
            }
            Tab(role: .search) {
                NavigationStack {
                    CountriesListView(focusSearchOnAppear: true)
                }
            }
        }
        .accentColor(.orange)
    }
}
