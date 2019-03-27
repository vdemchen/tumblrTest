import Foundation
import Kingfisher

class ImageService {
    open class func loadImageFromServer(url: String, id: String) -> Resource? {
        if let url: URL = URL(string: url) {
            let resource = ImageResource(downloadURL: url, cacheKey: id)
            return resource
        }
        return nil
    }
}
