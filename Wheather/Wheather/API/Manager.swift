import Foundation

struct Manager {
    let apiKey: String
    init() {
        if let keyPath = Bundle.main.infoDictionary?["WHEATHER_API_KEY"] as? String {
            apiKey = keyPath
        } else {
            apiKey = ""
        }
    }
}
