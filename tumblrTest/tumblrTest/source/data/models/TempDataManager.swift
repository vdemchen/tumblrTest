
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
                photo: item.photos?.first?.originalSize
            )
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
    let photo: Size?
    
    init(
        type: TypeEnum,
        blogName: String,
        blog: ResponseBlog,
        id: Int,
        photo: Size?
        ) {
        self.type = type
        self.blogName = blogName
        self.blog = blog
        self.id = id
        self.photo = photo
    }

}
