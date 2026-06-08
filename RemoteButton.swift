import SwiftUI

struct RemoteButton: View {
    let title: String
    var size: CGFloat = 64
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .frame(width: size, height: size)
                .background(.thinMaterial)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}
