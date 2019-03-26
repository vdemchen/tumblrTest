import UIKit
import SwiftEntryKit

class PopupView: UIView {
    
    @IBOutlet private weak var infoLabel: UILabel!
    
    private var popupAttributes: EKAttributes {
        var attributes = EKAttributes()
        attributes = .bottomFloat
        attributes.displayDuration = 3
        attributes.precedence = .enqueue(priority: .normal)
        attributes.entryInteraction = .absorbTouches
        return attributes
    }
    
    public func showNotificationMessage(title: String, colorView: UIColor = UIColor.blue) {
        let view = Bundle.main.loadNibNamed(PopupView.className(), owner: self, options: nil)?.first as! PopupView
        view.backgroundColor = colorView
        view.infoLabel.text = title
        SwiftEntryKit.display(entry: view, using: self.popupAttributes, presentInsideKeyWindow: true)
    }

    @IBAction func pressedCloseButton(_ sender: UIButton) {
        SwiftEntryKit.dismiss()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 10
        layer.masksToBounds = false
    }
}
