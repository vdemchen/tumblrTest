import Foundation

enum Result<T> {
    case success(T)
    case error(Error?)
}

//MARK: Base

typealias PostHandler = (Result<PostModel>) -> ()
