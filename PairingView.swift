import SwiftUI

struct PairingView: View {
    let device: TVDevice
    @EnvironmentObject private var remote: GoogleTVRemoteService
    @State private var code = ""
    @State private var goRemote = false

    var body: some View {
        VStack(spacing: 20) {
            Text(device.name)
                .font(.title2.bold())

            Text("TV ekranında çıkan eşleştirme kodunu gir.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            TextField("Örn: A1B2C3", text: $code)
                .textInputAutocapitalization(.characters)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Bağlan") {
                remote.pair(device: device, code: code)
                goRemote = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(code.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

            Text(remote.statusText)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationDestination(isPresented: $goRemote) {
            RemoteControlView().environmentObject(remote)
        }
    }
}
