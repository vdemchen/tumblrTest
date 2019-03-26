import UIKit
import SnapKit

struct CellEvents {
    let openInfoEvent: (ItemModel) -> Void
}

class PostTableViewCell: BaseTableViewCell {

    //MARK: - Views
    
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var readMoreButton: UIButton!
    @IBOutlet private weak var contentImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    @IBOutlet private weak var contentImageHeight: NSLayoutConstraint!
    
    //MARK: - Private properties
    
    private let worker = FindWorker()
    private let imageService = ImageService()
    
    //MARK: - Public properties
    
    public var events: CellEvents?
    
    public var feed: ItemModel? {
        didSet {
            guard let feed = feed else { return }
            self.setupData(feed: feed)
        }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    
    //MARK: - Private methodes
    
    private func setupData(feed: ItemModel) {
        self.authorLabel.text = feed.blogName
        self.titleLabel.text = feed.blog.title
        self.descriptionLabel.text = feed.blog.description.removeHTMLTag()
        self.contentImage.kf.setImage(with: self.imageService.loadImageFromServer(
            url: feed.photos?.first?.altSizes.first?.url ?? "",
            id: String(feed.id)
        ))
        
        if feed.type == TypeEnum.photo,
            let size: Size = feed.photos?.first?.altSizes.first {
            self.setupImageHeight(size: size)
        } else {
            self.anotherContent(feedType: feed.type)
        }
    }
    
    private func setupImageHeight(size: Size) {
        let multipire: CGFloat = UIScreen.main.bounds.width / CGFloat(size.width)
        self.contentImageHeight.constant = CGFloat(size.height) * multipire
    }
    
    private func anotherContent(feedType: TypeEnum) {
        switch feedType {
        case .video:
            self.contentImageHeight.constant = 60
            if let image: UIImage = UIImage(named: Keys.Images.videoIcon.rawValue) {
                self.contentImage.image = image
            }
            self.contentImage.contentMode = .scaleAspectFit
        default:
            self.contentImageHeight.constant = 0
        }
    }
    
    private func setupButton() {
        self.readMoreButton.addTarget(self, action: #selector(self.openPostInfo), for: .touchUpInside)
    }
    
    @objc private func openPostInfo() {
        if let feed = self.feed {
            self.events?.openInfoEvent(feed)
        }
    }
    
}
