import Foundation
import Combine

final class GoogleTVRemoteService: ObservableObject {
    @Published var isConnected = false
    @Published var statusText = "Bağlı değil"
    @Published var selectedDevice: TVDevice?

    func pair(device: TVDevice, code: String) {
        selectedDevice = device
        statusText = "Eşleştirme hazırlanıyor..."

        // TODO: AndroidTVRemoteControl paketi burada bağlanacak.
        // PairingManager ile TV'ye bağlanılır, TV'de görünen kod gönderilir.
        // Başarılı olursa isConnected = true yapılır.

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.statusText = "Demo mod: eşleşmiş gibi gösteriliyor"
            self.isConnected = true
        }
    }

    func send(_ command: RemoteCommand) {
        guard isConnected else {
            statusText = "Önce TV'ye bağlan"
            return
        }

        // TODO: RemoteManager.send(...) ile gerçek komut gönderilecek.
        statusText = "Gönderildi: \(command.rawValue)"
    }

    func disconnect() {
        isConnected = false
        selectedDevice = nil
        statusText = "Bağlantı kapandı"
    }
}
