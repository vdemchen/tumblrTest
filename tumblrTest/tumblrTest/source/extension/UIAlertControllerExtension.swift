
import Foundation
import UIKit

extension UIViewController {
    func showAlertWith(title: String) {
        let alertController = UIAlertController.init(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction.init(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlertWith(message: String) {
        let alertController = UIAlertController.init(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showTwoActionAlertWith(title: String, completion: ((_ state: Bool) -> Void)?) {
        let alertController = UIAlertController.init(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        let noAction = UIAlertAction.init(title: "NO", style: .cancel) { (action) in
            completion?(false)
        }
        
        let yesAction = UIAlertAction.init(title: "YES", style: .`default`) { (action) in
            completion?(true)
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
