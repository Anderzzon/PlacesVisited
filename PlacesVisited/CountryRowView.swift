import SwiftUI

struct CountryRowView: View {
    @ObservedObject var country: Country
    let mode: RowMode

    enum RowMode {
        case visited, wantToGo
    }

    var body: some View {
        HStack {
            Text(country.flagIcon).font(.title2)
            Text(country.fullName)
            Spacer()
            if mode == .visited, country.visited {
                Image(systemName: "figure.walk.circle.fill").foregroundColor(.orange)
            } else if mode == .wantToGo, country.wantToGo {
                Image(systemName: "bookmark.fill").foregroundColor(.orange)
            }
        }
    }
}
