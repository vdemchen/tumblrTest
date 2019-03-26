
import Foundation
import Kingfisher

typealias FindFeedHandler = (Result<Bool>) -> ()

class FindWorker {
    open func findFeed(tag: String, completion: @escaping FindFeedHandler) {
        RequestBuilder.findPost(tag: tag) { (result) in
            switch result {
            case .success(let data):
                TempDataManager.deleteItems()
                TempDataManager.updateItems(data: data.response)
                completion(.success(true))
            case .error(let error):
                TempDataManager.deleteItems()
                completion(.error(error))
            }
        }
    }
}
