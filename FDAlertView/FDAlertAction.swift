import UIKit

enum FDAlertActionStyle {
    
    case cancel
    case `default`
    case destructive
    case positive
    
}

class FDAlertAction: UIButton {
    
    private var handler: (() -> Void)?
    
    public var delegate: FDAlertViewDelegate?
    public var style: FDAlertActionStyle!
    public var cornerRadius: CGFloat = 8.0
    public var letterSpacing: Double = 3.0
    public var fontSize: CGFloat = 17.0
    
    convenience init(title: String, style: FDAlertActionStyle, handler: (() -> Void)?) {
        self.init()
        self.style = style
        self.configure(title: title, style: style, handler: handler)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    private func setUp() {
        self.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchUpInside(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(buttonTouchUp(_:)), for: .touchUpOutside)
        self.addTarget(self, action: #selector(buttonTouchUp(_:)), for: .touchDragExit)
        self.addTarget(self, action: #selector(buttonTouchUp(_:)), for: .touchCancel)
    }
    
    @objc func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.titleLabel?.alpha = 0.4
        }
    }
    
    @objc func buttonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.titleLabel?.alpha = 1.0
        }
    }
    
    @objc func buttonTouchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.titleLabel?.alpha = 1.0
        }
        
        DispatchQueue.main.async {
            self.handler?()
            self.delegate?.hide()
        }
    }
    
    private func configure(title: String, style: FDAlertActionStyle, handler: (() -> Void)?) {
        switch style {
        case .cancel:
            backgroundColor = UIColor.clear
            setTitleColor(UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0), for: .normal)
        case .default:
            backgroundColor = UIColor(red: 74/255, green: 112/255, blue: 251/255, alpha: 1.0)
            setTitleColor(UIColor.white, for: .normal)
        case .destructive:
            backgroundColor = UIColor(red: 234/255, green: 61/255, blue: 61/255, alpha: 1.0)
            setTitleColor(UIColor.white, for: .normal)
        case .positive:
            backgroundColor = UIColor(red: 80/255, green: 227/255, blue: 194/255, alpha: 1.0)
            setTitleColor(UIColor.white, for: .normal)
        }
        
        setTitle(title.uppercased(), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        titleLabel?.setLetterSpacing(value: letterSpacing)
        layer.cornerRadius = cornerRadius
        
        self.handler = handler
    }
    
    
    
}
