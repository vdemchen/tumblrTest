import UIKit

class InfoVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    private var feed: ItemModel?
    
    public var setupData: ItemModel? {
        didSet {
            self.feed = self.setupData
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupImageScroll()
    }
    
    private func setupView() {
        guard let feed = self.feed else {
            PopupView().showNotificationMessage(title: "Can`t open!", colorView: UIColor.red)
            return
        }
        self.addImage(feed)
        self.titleLabel.text = feed.blog.title
        self.descriptionView.text = feed.blog.description.removeHTMLTag()
    }
    
    private func addImage(_ feed: ItemModel) {
        if feed.type != .photo {
            self.contentImage.image = UIImage(named: Keys.Images.videoIcon.rawValue)
            self.scrollView.isScrollEnabled = false
            return
        }
        self.contentImage.kf.setImage(
            with: ImageService.loadImageFromServer(
                url: feed.photo?.url ?? "",
                id: String(feed.id)
        ))
    }
    
    private func setupImageScroll() {
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
    }
    
}

extension InfoVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentImage
    }
}
