import SwiftUI

struct CountryEditSheet: View {
    let country: Country
    @EnvironmentObject var countries: AppViewModel
    @Environment(\.dismiss) private var dismiss

    enum Selection { case none, wantToGo, visited }

    @State private var selection: Selection = .none
    @State private var visitYear: Int = Calendar.current.component(.year, from: Date())

    private let currentYear = Calendar.current.component(.year, from: Date())

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text(country.flagIcon).font(.largeTitle)
                        Text(country.fullName).font(.headline)
                    }
                    .padding(.vertical, 4)
                }

                Section {
                    Button(action: { selection = .wantToGo }) {
                        HStack {
                            Image(systemName: selection == .wantToGo ? "circle.fill" : "circle")
                                .foregroundColor(selection == .wantToGo ? .orange : .secondary)
                            Text("Want to go")
                                .foregroundColor(.primary)
                            Image(systemName: "bookmark.fill").foregroundColor(.orange)
                        }
                    }
                    Button(action: { selection = .visited }) {
                        HStack {
                            Image(systemName: selection == .visited ? "circle.fill" : "circle")
                                .foregroundColor(selection == .visited ? .orange : .secondary)
                            Text("Visited")
                                .foregroundColor(.primary)
                            Image(systemName: "mappin.and.ellipse").foregroundColor(.orange)
                        }
                    }

                    if selection == .visited {
                        Picker("First time visited", selection: $visitYear) {
                            ForEach((1950...currentYear).reversed(), id: \.self) { year in
                                Text(String(year)).tag(year)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit status")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                        dismiss()
                    }
                }
            }
            .onAppear { loadExistingData() }
        }
    }

    private func loadExistingData() {
        if country.visited {
            selection = .visited
            if let date = country.firstVisited {
                visitYear = Calendar.current.component(.year, from: date)
            }
        } else if country.wantToGo {
            selection = .wantToGo
        } else {
            selection = .none
        }
    }

    private func save() {
        let isVisited = selection == .visited
        let isWantToGo = selection == .wantToGo
        let firstVisitedDate: Date? = isVisited ? dateFromYear(visitYear) : nil
        countries.saveCountryStatus(
            country: country,
            visited: isVisited,
            wantToGo: isWantToGo,
            firstVisited: firstVisitedDate
        )
    }

    private func dateFromYear(_ year: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }
}
