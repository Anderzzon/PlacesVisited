import SwiftUI

struct CountryRowView: View {
    let country: Country
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
                Image(systemName: "checkmark.circle.fill").foregroundColor(.orange)
            } else if mode == .wantToGo, country.wantToGo {
                Image(systemName: "heart.fill").foregroundColor(.orange)
            }
        }
    }
}
