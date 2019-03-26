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
    let postURL: String
    let slug, date: String
    let timestamp: Int
    let state: State
    let format: Format
    let reblogKey: String
    let tags: [String]
    let shortURL: String
    let summary: String
    let shouldOpenInLegacy: Bool
    let recommendedSource, recommendedColor: JSONNull?
    let featuredInTag: [FeaturedInTag]
    let featuredTimestamp, noteCount: Int
    let caption: String
    let reblog: Reblog
    let trail: [Trail]
    let photosetLayout: String?
    let photos: [Photo]
    let canLike, canReblog, canSendInMessage, canReply: Bool
    let displayAvatar: Bool
    let imagePermalink: String?
    let sourceURL: String?
    let sourceTitle: String?
    let linkURL: String?
    let isAnonymous, isSubmission: Bool?
    
    enum CodingKeys: String, CodingKey {
        case type
        case blogName = "blog_name"
        case blog, id
        case postURL = "post_url"
        case slug, date, timestamp, state, format
        case reblogKey = "reblog_key"
        case tags
        case shortURL = "short_url"
        case summary
        case shouldOpenInLegacy = "should_open_in_legacy"
        case recommendedSource = "recommended_source"
        case recommendedColor = "recommended_color"
        case featuredInTag = "featured_in_tag"
        case featuredTimestamp = "featured_timestamp"
        case noteCount = "note_count"
        case caption, reblog, trail
        case photosetLayout = "photoset_layout"
        case photos
        case canLike = "can_like"
        case canReblog = "can_reblog"
        case canSendInMessage = "can_send_in_message"
        case canReply = "can_reply"
        case displayAvatar = "display_avatar"
        case imagePermalink = "image_permalink"
        case sourceURL = "source_url"
        case sourceTitle = "source_title"
        case linkURL = "link_url"
        case isAnonymous = "is_anonymous"
        case isSubmission = "is_submission"
    }
}

struct ResponseBlog: Codable {
    let name, title, description: String
    let url: String
    let uuid: String
    let updated: Int
}

enum FeaturedInTag: String, Codable {
    case lol = "LOL"
}

enum Format: String, Codable {
    case html = "html"
}

struct Photo: Codable {
    let caption: String
    let originalSize: Size
    let altSizes: [Size]
    let exif: Exif?
    
    enum CodingKeys: String, CodingKey {
        case caption
        case originalSize = "original_size"
        case altSizes = "alt_sizes"
        case exif
    }
}

struct Size: Codable {
    let url: String
    let width, height: Int
}

struct Exif: Codable {
    let camera: String
    
    enum CodingKeys: String, CodingKey {
        case camera = "Camera"
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

struct Trail: Codable {
    let blog: TrailBlog
    let post: Post
    let contentRaw, content: String
    let isCurrentItem, isRootItem: Bool
    
    enum CodingKeys: String, CodingKey {
        case blog, post
        case contentRaw = "content_raw"
        case content
        case isCurrentItem = "is_current_item"
        case isRootItem = "is_root_item"
    }
}

struct TrailBlog: Codable {
    let name: String
    let active: Bool
    let theme: Theme
    let shareLikes, shareFollowing, canBeFollowed: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, active, theme
        case shareLikes = "share_likes"
        case shareFollowing = "share_following"
        case canBeFollowed = "can_be_followed"
    }
}

struct Theme: Codable {
    let headerFullWidth, headerFullHeight, headerFocusWidth, headerFocusHeight: Int?
    let avatarShape: AvatarShape
    let backgroundColor: String
    let bodyFont: Font
    let headerBounds: HeaderBounds
    let headerImage, headerImageFocused, headerImageScaled: String
    let headerStretch: Bool
    let linkColor: LinkColor
    let showAvatar, showDescription, showHeaderImage, showTitle: Bool
    let titleColor: TitleColor
    let titleFont: Font
    let titleFontWeight: TitleFontWeight
    
    enum CodingKeys: String, CodingKey {
        case headerFullWidth = "header_full_width"
        case headerFullHeight = "header_full_height"
        case headerFocusWidth = "header_focus_width"
        case headerFocusHeight = "header_focus_height"
        case avatarShape = "avatar_shape"
        case backgroundColor = "background_color"
        case bodyFont = "body_font"
        case headerBounds = "header_bounds"
        case headerImage = "header_image"
        case headerImageFocused = "header_image_focused"
        case headerImageScaled = "header_image_scaled"
        case headerStretch = "header_stretch"
        case linkColor = "link_color"
        case showAvatar = "show_avatar"
        case showDescription = "show_description"
        case showHeaderImage = "show_header_image"
        case showTitle = "show_title"
        case titleColor = "title_color"
        case titleFont = "title_font"
        case titleFontWeight = "title_font_weight"
    }
}

enum AvatarShape: String, Codable {
    case circle = "circle"
    case square = "square"
}

enum Font: String, Codable {
    case capita = "Capita"
    case gibson = "Gibson"
    case helveticaNeue = "Helvetica Neue"
}

enum HeaderBounds: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(HeaderBounds.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for HeaderBounds"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

enum LinkColor: String, Codable {
    case the213F52 = "#213f52"
    case the529ECC = "#529ECC"
    case the52C8Cc = "#52c8cc"
}

enum TitleColor: String, Codable {
    case the444444 = "#444444"
}

enum TitleFontWeight: String, Codable {
    case bold = "bold"
}

struct Post: Codable {
    let id: String
}

enum TypeEnum: String, Codable {
    case photo = "photo"
}

// MARK: Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
