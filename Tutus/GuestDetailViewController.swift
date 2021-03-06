import UIKit

class GuestDetailViewController: UIViewController {
    
    // MARK: Properties & Outlets
    @IBOutlet weak var nameLabel: UILabel!
    
    var guestDetailViewModel: GuestDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nameLabel.text = guestDetailViewModel?.name()
        
    }
}
