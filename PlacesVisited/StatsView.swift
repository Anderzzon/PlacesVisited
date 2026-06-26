import SwiftUI

struct StatsView: View {
    @EnvironmentObject var countries: AppViewModel
    @State private var bucketProgress: CGFloat = 0
    @State private var worldProgress: CGFloat = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                VStack(spacing: 8) {
                    BucketCircleView(progress: bucketProgress,
                                     centerText: "\(Int(countries.bucketListProgress()))%",
                                     diameter: 240)
                    Text("My bucket list")
                        .font(.headline).foregroundColor(.orange)
                    Text("\(countries.numberOfCountriesWantToGoTo) more to go")
                        .font(.subheadline).foregroundColor(.orange)
                }

                Divider()

                HStack(spacing: 0) {
                    SmallStatView(progress: 1.0,
                                  value: "\(countries.numberOfCountriesVisited)",
                                  label: "Countries\nvisited")
                    SmallStatView(progress: 1.0,
                                  value: "\(countries.numberOfCountriesWantToGoTo)",
                                  label: "On your\nbucket list")
                    SmallStatView(progress: worldProgress,
                                  value: "\(countries.percentOfWorldVisited())%",
                                  label: "Of the\nworld")
                }
            }
            .padding(.vertical, 32)
        }
        .navigationTitle("Stats")
        .onAppear {
            countries.loadItems()
            animateStats()
        }
    }

    private func animateStats() {
        withAnimation(.easeInOut(duration: 0.8)) {
            bucketProgress = CGFloat(countries.bucketListProgress() / 100)
            worldProgress = CGFloat(countries.percentOfWorldVisited() / 100)
        }
    }
}

struct BucketCircleView: View {
    let progress: CGFloat
    let centerText: String
    let diameter: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray4), lineWidth: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text(centerText)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.orange)
        }
        .frame(width: diameter, height: diameter)
    }
}

struct SmallStatView: View {
    let progress: CGFloat
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(Color(.systemGray4), lineWidth: 4)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.orange, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text(value)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.orange)
            }
            .frame(width: 80, height: 80)
            Text(label)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.orange)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}
