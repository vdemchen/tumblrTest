
import Foundation

class TempDataManager {
    public static let shared = TempDataManager()
    
    public var items: [ItemModel] = []
    
    class func updateItems(data: [Response]) {
        data.forEach { (item) in
            let newItem: ItemModel = ItemModel(
                type: item.type,
                blogName: item.blogName,
                blog: item.blog,
                id: item.id,
                photos: item.photos
            )
            print(newItem)
            self.shared.items.append(newItem)
        }
    }
    
    class func deleteItems() {
        self.shared.items = []
    }
}

struct ItemModel {
    let type: TypeEnum
    let blogName: String
    let blog: ResponseBlog
    let id: Int
    let photos: [Photo]?
    
    init(
        type: TypeEnum,
        blogName: String,
        blog: ResponseBlog,
        id: Int,
        photos: [Photo]?
        ) {
        self.type = type
        self.blogName = blogName
        self.blog = blog
        self.id = id
        self.photos = photos
    }

}
