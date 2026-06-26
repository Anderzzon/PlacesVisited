import SwiftUI

struct CountryRowView: View {
    @ObservedObject var country: Country

    var body: some View {
        HStack {
            Text(country.flagIcon).font(.title2)
            Text(country.fullName)
            Spacer()
            if country.visited {
                Image(systemName: "mappin.and.ellipse").foregroundColor(.orange)
            } else if country.wantToGo {
                Image(systemName: "bookmark.fill").foregroundColor(.orange)
            }
        }
    }
}
