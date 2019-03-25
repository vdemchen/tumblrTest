
import UIKit

class PostTableViewCell: BaseTableViewCell {

    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var readMoreButton: UIButton!
    @IBOutlet private weak var contentImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var contentImageHeight: NSLayoutConstraint!
    
    public var feed: ItemModel? {
        didSet {
            self.authorLabel.text = feed?.blogName
            self.titleLabel.text = feed?.blog.title
            self.descriptionLabel.text = feed?.blog.description
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
