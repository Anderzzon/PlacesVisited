import SwiftUI
import MapKit
import Combine

struct MapViewRepresentable: UIViewRepresentable {
    @EnvironmentObject var countries: AppViewModel
    @EnvironmentObject var mapDataStore: MapDataStore
    @Binding var selectedCountry: Country?

    func makeCoordinator() -> Coordinator {
        Coordinator(selectedCountry: $selectedCountry)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        context.coordinator.mapView = mapView

        let center = CLLocationCoordinate2D(latitude: 55.663255, longitude: 13.597545)
        let region = MKCoordinateRegion(center: center,
                                        latitudinalMeters: 5_000_000,
                                        longitudinalMeters: 5_000_000)
        mapView.setRegion(region, animated: false)
        mapView.setCameraZoomRange(
            MKMapView.CameraZoomRange(minCenterCoordinateDistance: 2_500_000,
                                      maxCenterCoordinateDistance: 100_000_000),
            animated: false)

        let tap = UITapGestureRecognizer(target: context.coordinator,
                                         action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tap)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinator = context.coordinator
        coordinator.countries = countries
        coordinator.overlayDict = mapDataStore.overlayDict

        if mapDataStore.isReady && !coordinator.overlaysAdded {
            coordinator.overlaysAdded = true
            coordinator.renderOverlayToMap(mapView: uiView)
        }
        if coordinator.overlaysAdded {
            coordinator.updateOverlayColors(mapView: uiView)
        }
    }

    // MARK: - Coordinator

    class Coordinator: NSObject, MKMapViewDelegate {
        @Binding var selectedCountry: Country?

        weak var mapView: MKMapView?
        var countries: AppViewModel?
        var overlayDict: [String: CountryGeo] = [:]
        var overlaysAdded = false
        var cancellables = Set<AnyCancellable>()

        init(selectedCountry: Binding<Country?>) {
            _selectedCountry = selectedCountry
        }

        func renderOverlayToMap(mapView: MKMapView) {
            for (_, countryGeo) in overlayDict {
                for polygon in countryGeo.polygons {
                    mapView.addOverlay(polygon, level: .aboveRoads)
                }
            }
        }

        func updateOverlayColors(mapView: MKMapView) {
            guard let countries = countries else { return }

            var countriesToLoop = countries.listOfCountriesToUpdate(for: .Europe)
            countriesToLoop += countries.listOfCountriesToUpdate(for: .Asia)
            countriesToLoop += countries.listOfCountriesToUpdate(for: .Africa)
            countriesToLoop += countries.listOfCountriesToUpdate(for: .NorthAmerica)
            countriesToLoop += countries.listOfCountriesToUpdate(for: .SouthAmerica)
            countriesToLoop += countries.listOfCountriesToUpdate(for: .Oceania)

            for country in countriesToLoop {
                guard let overlays = overlayDict[country.shortName]?.polygons else { continue }

                var identifier = ""
                if country.visited { identifier = "visited" }
                else if country.wantToGo { identifier = "wantToGo" }

                for overlay in overlays {
                    overlay.identifier = identifier
                }
                for overlay in mapView.overlays {
                    if let renderer = mapView.renderer(for: overlay) as? MKPolygonRenderer {
                        configureColor(renderer: renderer, overlay: overlay)
                    }
                }
                country.updateMap = false
            }
        }

        func configureColor(renderer: MKPolygonRenderer, overlay: MKOverlay) {
            let visitedColor = UIColor(named: "VisitedColor")
            let fillColor: UIColor
            var alpha: CGFloat = 0.8
            if let polygon = overlay as? CustomPolygon, polygon.identifier == "visited" {
                fillColor = visitedColor ?? .green
                alpha = 1.0
            } else if let polygon = overlay as? CustomPolygon, polygon.identifier == "wantToGo" {
                fillColor = .orange
                alpha = 1.0
            } else {
                fillColor = .red
                alpha = 0.0
            }
            renderer.fillColor = fillColor.withAlphaComponent(alpha)
        }

        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard sender.state == .ended,
                  let mapView = sender.view as? MKMapView,
                  let countries = countries else { return }

            let locationInView = sender.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)

            for (_, countryGeo) in overlayDict {
                for polygon in countryGeo.polygons {
                    let renderer = MKPolygonRenderer(polygon: polygon)
                    let mapPoint = MKMapPoint(tappedCoordinate)
                    let viewPoint = renderer.point(for: mapPoint)
                    guard renderer.path.contains(viewPoint) else { continue }

                    var allCountries = countries.listOfCountries(for: .Europe)
                    allCountries += countries.listOfCountries(for: .Asia)
                    allCountries += countries.listOfCountries(for: .Africa)
                    allCountries += countries.listOfCountries(for: .NorthAmerica)
                    allCountries += countries.listOfCountries(for: .SouthAmerica)
                    allCountries += countries.listOfCountries(for: .Oceania)

                    for country in allCountries {
                        if countryGeo.isoA3 == country.shortName {
                            DispatchQueue.main.async {
                                self.selectedCountry = country
                            }
                            return
                        }
                    }
                }
            }
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolygonRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.black
            renderer.lineWidth = 0.3
            configureColor(renderer: renderer, overlay: overlay)
            return renderer
        }
    }
}
