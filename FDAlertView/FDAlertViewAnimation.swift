import UIKit

extension FDAlertView {
    
    public func show(in viewController: UIViewController) {
        configure()
        
        self.alpha = 0.0
        self.containerView.center = self.center
        self.containerView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        viewController.view.addSubview(self)
        
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.alpha = 1.0
            })
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: [.curveEaseInOut], animations: {
                self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        } else {
            self.alpha = 1.0
            self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    public func hide() {
        if animated {
            UIView.animate(withDuration: 0.1, animations: {
                self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.alpha = 0.0
            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        } else {
            self.removeFromSuperview()
        }
    }
    
}
