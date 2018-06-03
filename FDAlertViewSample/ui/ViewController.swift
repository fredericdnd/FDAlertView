import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showAlert(_ sender: Any) {
        let alertView = FDAlertView(message: "Voulez-vous vraiment supprimer @jeandupont de vos amis ?")
        
        let action = FDAlertAction(title: "Supprimer", style: .default, handler: nil)
        
        alertView.addAction(action)
        alertView.addAction(FDAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertView.show(in: self)
    }
    
}
