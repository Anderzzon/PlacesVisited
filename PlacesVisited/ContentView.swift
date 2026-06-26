import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                CountriesListView()
            }
            .tabItem {
                Label("Countries", systemImage: "list.bullet")
            }

            NavigationStack {
                StatsView()
            }
            .tabItem {
                Label("Stats", systemImage: "chart.pie")
            }

            WorldMapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
        .accentColor(.orange)
    }
}
