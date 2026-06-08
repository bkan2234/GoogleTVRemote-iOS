import Foundation
import Network

final class DeviceDiscovery: ObservableObject {
    @Published var devices: [TVDevice] = []
    @Published var isSearching = false

    private var browser: NWBrowser?

    func start() {
        isSearching = true
        devices.removeAll()

        let parameters = NWParameters.tcp
        parameters.includePeerToPeer = true

        let browser = NWBrowser(for: .bonjour(type: "_androidtvremote2._tcp", domain: nil), using: parameters)
        self.browser = browser

        browser.browseResultsChangedHandler = { [weak self] results, _ in
            let mapped = results.compactMap { result -> TVDevice? in
                switch result.endpoint {
                case let .service(name, _, _, _):
                    return TVDevice(name: name, host: "Bulundu", port: 6467)
                default:
                    return nil
                }
            }

            DispatchQueue.main.async {
                self?.devices = Array(Set(mapped))
            }
        }

        browser.stateUpdateHandler = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .ready:
                    self?.isSearching = true
                case .failed, .cancelled:
                    self?.isSearching = false
                default:
                    break
                }
            }
        }

        browser.start(queue: .main)
    }

    func stop() {
        browser?.cancel()
        browser = nil
        isSearching = false
    }
}
