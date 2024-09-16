import Foundation
import UIKit

protocol AnimatedTextFieldDelegate: AnyObject {
    func textFieldDidBeginEditing(_ textField: AnimatedTextField)
    func textFieldDidEndEditing(_ textField: AnimatedTextField)
    func textField(_ textField: AnimatedTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}

@IBDesignable class AnimatedTextField: UIView {
    
    // MARK: - Properties

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    weak var delegate: AnimatedTextFieldDelegate?
    
    var placeholderFont: Float = 12
    var afterAnimationFont : Float = 10
    var animeDuration: Float = 0.3
    var placeholderTextColor : UIColor = UIColor.black
    var animatedTextColor : UIColor = UIColor.black
    var offSetX : Float = 0
    var bundle: String?
    @IBInspectable
    var placeholder: String = "label" {
        didSet {
            self.label.attributedText = placeholder.coloredPlaceHolderString()
        }
    }
    
    @IBInspectable
    var animationOffsetX: Float = 0 {
        didSet {
            self.offSetX = animationOffsetX
        }
    }
    
    @IBInspectable
    var beforeColor: UIColor = .black{
        didSet {
            self.placeholderTextColor = beforeColor
        }
    }
    
    @IBInspectable
    var afterColor: UIColor = .black{
        didSet {
            self.animatedTextColor = afterColor
        }
    }
    
    @IBInspectable
    var beforeFontSize: Float = 12 {
        didSet {
            self.placeholderFont = beforeFontSize
        }
    }
    
    @IBInspectable
    var afterFontSize: Float = 10 {
        didSet {
            self.afterAnimationFont = afterFontSize
        }
    }
    
    @IBInspectable
    var animationDuration: Float = 0.3 {
        didSet {
            self.animeDuration = animationDuration
        }
    }
    
    @IBInspectable
    var secureInput: Bool = false {
        didSet {
            self.textField.isSecureTextEntry = secureInput
        }
    }
    
    var text: String {
        get {
            return self.textField.text ?? ""
        }
        set {
            self.textField.text = newValue
        }
    }
    
    private var btnShowPassword: UIButton {
        let size: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 90.0 : 25.0
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Closed Eye Icon"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -(size / 2.0), bottom: 0, right: 0)
        button.frame = CGRect(x: self.frame.size.width - size - 10, y: 0.0, width: size, height: size)
        button.tintColor = .black
        button.addTarget(self, action: #selector(refreshContent), for: .touchUpInside)
        return button
    }
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        loadNib()
        setupUI()
        textField.delegate = self
    }
    
    private func loadNib() {
        let bundle = Bundle(for: type(of: self)) 
        let nib = UINib(nibName: "AnimatedTextField", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Could not load AnimatedTextField view from nib")
        }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    // MARK: - Configuration Methods

    func configureTextField(keyboardType: UIKeyboardType, contentType: UITextContentType, delegate: AnimatedTextFieldDelegate?) {
        self.textField.keyboardType = keyboardType
        self.textField.textContentType = contentType
        self.delegate = delegate
    }
    
    func showErrorMessage(_ message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    // MARK: - UI Setup Methods

    private func setupUI() {
            self.label.font = UIDevice.current.userInterfaceIdiom == .pad ? self.label.font.withSize(25) : self.label.font.withSize(15)
        self.label.textColor = beforeColor
        
    }
    
    // MARK: - User Defined Methods

    @objc private func refreshContent(button: UIButton) {
        textField.isSecureTextEntry.toggle()
        let imageName = textField.isSecureTextEntry ? "Closed Eye Icon" : "Open Eye Icon"
        button.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func hidePlaceholder() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            self.label.text = nil
        }, completion: nil)
    }
    
    func showPlaceholder() {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            self.label.text = self.placeholder
        }, completion: nil)
    }
    
    func showLabel() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: TimeInterval(self.animeDuration), delay: 0, options: .transitionFlipFromRight, animations: {
                self.label.alpha = 1.0
                self.label.textColor = self.afterColor
                self.label.font = UIDevice.current.userInterfaceIdiom == .pad ? self.label.font.withSize(20) : self.label.font.withSize(CGFloat(self.afterAnimationFont))
                self.label.transform = CGAffineTransform(translationX: CGFloat(self.offSetX), y: -(self.textField.frame.midY)/2)
                self.textField.transform = CGAffineTransform(translationX: CGFloat(self.offSetX), y: (self.textField.frame.midY)/2)
            }, completion: nil)
        }
    }
    
    func hideLabel() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: TimeInterval(self.animeDuration), delay: 0, options: .curveEaseInOut, animations: {
                self.label.alpha = 1.0
                self.label.textColor = self.beforeColor
                self.label.font = UIDevice.current.userInterfaceIdiom == .pad ? self.label.font.withSize(25) : self.label.font.withSize(CGFloat(self.beforeFontSize))
                self.label.transform = .identity
                self.textField.transform = .identity
            }, completion: nil)
        }
    }
    
    func materialTextFieldEndEditing() {
        textFieldDidBeginEditing(textField)
        textFieldDidEndEditing(textField)
    }
}

// MARK: - UITextFieldDelegate

extension AnimatedTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            //        resetTextField()
            showLabel()
        }
        delegate?.textFieldDidBeginEditing(self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text?.isEmpty ?? true) {
            resetTextField()
        }
        delegate?.textFieldDidEndEditing(self)
    }
    
    private func resetTextField() {
        hideLabel()
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?.textField(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}

extension String {
    func coloredPlaceHolderString() -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: self)
        
        // Check if the string ends with "*"
        if self.hasSuffix("*") {
            // Find the range of the "*" character at the end
            let range = (self as NSString).range(of: "*", options: .backwards)
            
            // Apply red color to the "*" at the end of the string
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        }
        
        return mutableAttributedString
    }
}
