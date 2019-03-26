import Foundation
import Alamofire

class RequestBuilder {
    class func findPost(
        tag: String,
        completion: @escaping PostHandler
        ) {
        
        let parameters: [String: String] =  [
            "api_key": Keys.Access.token.rawValue,
            "tag": tag
        ]
        
        RequestManager.request(
            url: Path.Request.tagged.url(),
            parameters: parameters,
            requestMethod: .get,
            URLEncoding(destination: .methodDependent)
        ) { (request) in
                switch request {
                case .success(let data):
                    do {
                        let result: PostModel = try JSONDecoder().decode(PostModel.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.error(error))
                    }
                case .error(let error):
                    completion(.error(error))
                }
        }
        
    }
    
}
