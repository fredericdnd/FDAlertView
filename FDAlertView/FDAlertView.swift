import UIKit

class FDAlertView: UIView, FDAlertViewDelegate {
    
    private var title: String?
    private var message: String?
    
    public var actions: [FDAlertAction] = []
    public var animated: Bool = true
    public var cornerRadius: CGFloat = 8.0
    public var alertWidth: CGFloat = 343.0
    public var actionHeight: CGFloat = 50.0
    public var padding: CGFloat = 16.0
    public var textColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1.0)
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    convenience init(title: String? = nil, message: String? = nil) {
        self.init(frame: UIScreen.main.bounds)
        
        self.title = title
        self.message = message
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    private func loadViewFromNib() -> UIView {
        let viewBundle = Bundle(for: type(of: self))
        let view = viewBundle.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)![0]
        
        return view as! UIView
    }
    
    private func setupView() {
        let nibView = loadViewFromNib()
        nibView.frame = bounds
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(nibView)
        
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hide(_:))))
        containerView.layer.cornerRadius = cornerRadius
        stackView.spacing = padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func hide(_ sender: Any) {
        self.hide()
    }
    
    public func addAction(_ action: FDAlertAction) {
        self.actions.append(action)
    }
    
    internal func configure() {
        if let title = title {
            addTitleToAlert(title: title)
        }
        
        if let message = message {
            addMessageToAlert(message: message)
        }
        
        for action in actions {
            addActionToAlert(action)
        }
    }
    
    private func addTitleToAlert(title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = textColor
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.0).isActive = true
        stackView.addArrangedSubview(titleLabel)
    }
    
    private func addMessageToAlert(message: String) {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.0).isActive = true
        stackView.addArrangedSubview(messageLabel)
    }
    
    private func addActionToAlert(_ action: FDAlertAction) {
        switch action.style {
        case .cancel:
            action.heightAnchor.constraint(equalToConstant: 60.0 - 32.0).isActive = true
            action.backgroundColor = UIColor.clear
        default:
            action.heightAnchor.constraint(equalToConstant: actionHeight).isActive = true
        }
        
        action.delegate = self
        stackView.addArrangedSubview(action)
    }
    
}

protocol FDAlertViewDelegate {
    
    func hide()
    
}
