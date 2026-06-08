import SwiftUI

struct ContentView: View {
    @StateObject private var discovery = DeviceDiscovery()
    @StateObject private var remote = GoogleTVRemoteService()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Google TV Remote")
                    .font(.largeTitle.bold())

                Text("Aynı Wi‑Fi ağındaki Google TV cihazlarını bul")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Button(discovery.isSearching ? "Aranıyor..." : "TV Ara") {
                    discovery.start()
                }
                .buttonStyle(.borderedProminent)

                List(discovery.devices) { device in
                    NavigationLink {
                        PairingView(device: device)
                            .environmentObject(remote)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(device.name).font(.headline)
                            Text("Google TV / Android TV").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
