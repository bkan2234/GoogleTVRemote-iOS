import SwiftUI

struct RemoteControlView: View {
    @EnvironmentObject private var remote: GoogleTVRemoteService

    var body: some View {
        VStack(spacing: 26) {
            HStack {
                RemoteButton(title: "⏻") { remote.send(.power) }
                Spacer()
                RemoteButton(title: "☰") { remote.send(.menu) }
            }

            Spacer()

            VStack(spacing: 14) {
                RemoteButton(title: "↑") { remote.send(.up) }

                HStack(spacing: 22) {
                    RemoteButton(title: "←") { remote.send(.left) }
                    RemoteButton(title: "OK", size: 78) { remote.send(.ok) }
                    RemoteButton(title: "→") { remote.send(.right) }
                }

                RemoteButton(title: "↓") { remote.send(.down) }
            }

            HStack(spacing: 18) {
                RemoteButton(title: "⌂") { remote.send(.home) }
                RemoteButton(title: "↩") { remote.send(.back) }
                RemoteButton(title: "⏯") { remote.send(.playPause) }
            }

            HStack(spacing: 18) {
                RemoteButton(title: "🔇") { remote.send(.mute) }
                RemoteButton(title: "−") { remote.send(.volumeDown) }
                RemoteButton(title: "+") { remote.send(.volumeUp) }
            }

            Text(remote.statusText)
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding(24)
        .navigationTitle("Kumanda")
        .navigationBarTitleDisplayMode(.inline)
    }
}
