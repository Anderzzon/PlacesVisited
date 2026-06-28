import SwiftUI
import Charts

struct StatsView: View {
    @EnvironmentObject var countries: AppViewModel
    @State private var chartVisible = false

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                if chartVisible {
                    CountryProgressChartView(
                        data: countries.travelProgressChartData,
                        target: countries.numberOfCountriesVisited + countries.numberOfCountriesWantToGoTo
                    )
                    .padding(.horizontal)
                } else {
                    Color.clear.frame(height: 256)
                }

                Divider()

                VStack(spacing: 8) {
                    BucketCircleView(progress: CGFloat(countries.bucketListProgress() / 100),
                                     centerText: "\(Int(countries.bucketListProgress()))%",
                                     diameter: 240)
                    Text("My bucket list")
                        .font(.headline).foregroundColor(.orange)
                    Text("\(countries.numberOfCountriesWantToGoTo) more to go")
                        .font(.subheadline).foregroundColor(.orange)
                    if let doneByText = {
                        let data = countries.travelProgressChartData
                        let allTime = data.last(where: { $0.series == .projected })?.year
                        let recent = data.last(where: { $0.series == .recentProjected })?.year
                        if let a = allTime, let r = recent {
                            let lo = min(a, r), hi = max(a, r)
                            return lo == hi ? "Done by \(String(lo))" : "Done by \(String(lo))–\(String(hi))"
                        } else if let year = allTime ?? recent {
                            return "Done by \(String(year))"
                        }
                        return nil
                    }() {
                        Text(doneByText)
                            .font(.caption)
                            .foregroundColor(.orange.opacity(0.6))
                    }
                }

                Divider()

                HStack(spacing: 0) {
                    SmallStatView(progress: 1.0,
                                  value: "\(countries.numberOfCountriesVisited)",
                                  label: "Countries\nvisited")
                    SmallStatView(progress: 1.0,
                                  value: "\(countries.numberOfCountriesWantToGoTo)",
                                  label: "On your\nbucket list")
                    SmallStatView(progress: CGFloat(countries.percentOfWorldVisited() / 100),
                                  value: "\(countries.percentOfWorldVisited())%",
                                  label: "Of the\nworld")
                }
            }
            .padding(.vertical, 32)
        }
        .navigationTitle("Stats")
        .task { chartVisible = true }
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

struct CountryProgressChartView: View {
    let data: [YearDataPoint]
    let target: Int

    private var firstYear: Int { data.first?.year ?? 0 }
    private var currentYear: Int { Calendar.current.component(.year, from: Date()) }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Travel progress")
                .font(.headline)
                .foregroundColor(.orange)

            if data.isEmpty {
                Text("Visit countries to see your progress")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, minHeight: 220, alignment: .center)
            } else {
                Chart {
                    ForEach(data.filter { $0.series == .actual }) { point in
                        LineMark(
                            x: .value("Year", point.year),
                            y: .value("Countries", point.count),
                            series: .value("Series", "actual")
                        )
                        .foregroundStyle(.orange)
                        .interpolationMethod(.stepEnd)
                    }

                    ForEach(data.filter { $0.series == .projected }) { point in
                        LineMark(
                            x: .value("Year", point.year),
                            y: .value("Countries", point.count),
                            series: .value("Series", "projected")
                        )
                        .foregroundStyle(.orange.opacity(0.45))
                        .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 3]))
                        .interpolationMethod(.linear)
                    }

                    ForEach(data.filter { $0.series == .recentProjected }) { point in
                        LineMark(
                            x: .value("Year", point.year),
                            y: .value("Countries", point.count),
                            series: .value("Series", "recentProjected")
                        )
                        .foregroundStyle(.gray.opacity(0.5))
                        .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 3]))
                        .interpolationMethod(.linear)
                    }

                    if target > 0 {
                        RuleMark(y: .value("Goal", target))
                            .foregroundStyle(.orange.opacity(0.0))
                            .annotation(position: .top, alignment: .trailing) {
                                Text("Goal: \(target)")
                                    .font(.caption2)
                                    .foregroundColor(.orange)
                            }
                    }
                }
                .chartXScale(domain: (data.first?.year ?? 0)...(data.map { $0.year }.max() ?? 1))
                .chartPlotStyle { $0.padding(.trailing, 24) }
                .chartYScale(domain: 0...max(target, 1))
                .chartXAxis {
                    AxisMarks(values: [firstYear, currentYear]) { value in
                        AxisTick()
                        AxisValueLabel {
                            if let year = value.as(Int.self) {
                                Text(String(year))
                            }
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(values: .automatic) {
                        AxisValueLabel()
                    }
                }
                .frame(height: 220)

                HStack(spacing: 16) {
                    LegendItem(color: .orange, dashed: false, label: "Visited")
                    LegendItem(color: .orange.opacity(0.45), dashed: true, label: "All-time pace")
                    LegendItem(color: .gray.opacity(0.5), dashed: true, label: "3-year pace")
                }
                .padding(.top, 4)
            }
        }
    }
}

private struct LegendItem: View {
    let color: Color
    let dashed: Bool
    let label: String

    var body: some View {
        HStack(spacing: 6) {
            if dashed {
                Path { path in
                    path.move(to: .init(x: 0, y: 4))
                    path.addLine(to: .init(x: 20, y: 4))
                }
                .stroke(color, style: StrokeStyle(lineWidth: 2, dash: [4, 2]))
                .frame(width: 20, height: 8)
            } else {
                Rectangle()
                    .fill(color)
                    .frame(width: 20, height: 2)
            }
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
