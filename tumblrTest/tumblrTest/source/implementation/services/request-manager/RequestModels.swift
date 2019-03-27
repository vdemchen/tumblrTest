import Foundation

struct PostModel: Codable {
    let meta: Meta
    let response: [Response]
}

struct Meta: Codable {
    let status: Int
    let msg: String
}

struct Response: Codable {
    let type: TypeEnum
    let blogName: String
    let blog: ResponseBlog
    let id: Int
    let photos: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case blogName = "blog_name"
        case blog, id
        case photos
    }
}

struct ResponseBlog: Codable {
    let name, title, description: String
    let url: String
    let uuid: String
    let updated: Int
}

enum Format: String, Codable {
    case html = "html"
}

struct Photo: Codable {
    let caption: String
    let originalSize: Size
//    let altSizes: [Size]
    
    enum CodingKeys: String, CodingKey {
        case caption
        case originalSize = "original_size"
//        case altSizes = "alt_sizes"
    }
}

struct Size: Codable {
    let url: String
    let width, height: Int
}

struct Player: Codable {
    let width: Int
    let embedCode: String
    
    enum CodingKeys: String, CodingKey {
        case width
        case embedCode = "embed_code"
    }
}

struct Reblog: Codable {
    let comment, treeHTML: String
    
    enum CodingKeys: String, CodingKey {
        case comment
        case treeHTML = "tree_html"
    }
}

enum State: String, Codable {
    case published = "published"
}

enum AvatarShape: String, Codable {
    case circle = "circle"
    case square = "square"
}

enum BodyFont: String, Codable {
    case helveticaNeue = "Helvetica Neue"
}

enum TitleFontWeight: String, Codable {
    case bold = "bold"
}

enum TypeEnum: String, Codable {
    case link = "link"
    case photo = "photo"
    case text = "text"
    case video = "video"
}

struct Video: Codable {
    let youtube: Youtube
}

struct Youtube: Codable {
    let videoID: String
    let width, height: Int
    
    enum CodingKeys: String, CodingKey {
        case videoID = "video_id"
        case width, height
    }
}
