
import Foundation

extension NSError {
    static let noInternetConnection: NSError = NSError(
        domain: "No internet connection",
        code: 1001,
        userInfo: nil
    )
    static let serverError: NSError = NSError(
        domain: "Server error",
        code: 1002,
        userInfo: nil
    )
}
