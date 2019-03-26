import Foundation

extension String {
    func removeHTMLTag() -> String {
        
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
    }
}
