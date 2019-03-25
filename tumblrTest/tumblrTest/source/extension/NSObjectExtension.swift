
import Foundation

extension NSObject {
    class func className() -> String {
        return String(describing: self)
    }
}
