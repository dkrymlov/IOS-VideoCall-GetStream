import SwiftUI
import StreamVideo
import StreamVideoSwiftUI

@main
struct VideoCallApp: App {
    @ObservedObject var viewModel: CallViewModel

    private var client: StreamVideo
    private let apiKey: String = "mmhfdzb5evj2" // The API key can be found in the Credentials section
    private let userId: String = "Biggsa_Darklighter" // The User Id can be found in the Credentials section
    private let token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiQmlnZ3NfRGFya2xpZ2h0ZXIiLCJpc3MiOiJwcm9udG8iLCJzdWIiOiJ1c2VyL0JpZ2dzX0RhcmtsaWdodGVyIiwiaWF0IjoxNjk5ODg1OTgxLCJleHAiOjE3MDA0OTA3ODZ9.iKI5bl2HFtuyorbsNflVWsH4pBQNcfII6QTI288Bnt4" // The Token can be found in the Credentials section
    private let callId: String = "BGbnzTuUs8Ic" // The CallId can be found in the Credentials section

    init() {
        let user = User(
            id: userId,
            name: "Danylo Krymlov", // name and imageURL are used in the UI
            imageURL: .init(string: "https://getstream.io/static/2796a305dd07651fcceb4721a94f4505/a3911/martin-mitrevski.webp")
        )

        // Initialize Stream Video client
        self.client = StreamVideo(
            apiKey: apiKey,
            user: user,
            token: .init(stringLiteral: token)
        )

        self.viewModel = .init()
    }

    var body: some Scene {
        WindowGroup {
            VStack {
                if viewModel.call != nil {
                    CallContainer(viewFactory: DefaultViewFactory.shared, viewModel: viewModel)
                } else {
                    Text("loading...")
                }
            }.onAppear {
                Task {
                    guard viewModel.call == nil else { return }
                    viewModel.joinCall(callType: .default, callId: callId)
                }
            }
        }
    }
}
