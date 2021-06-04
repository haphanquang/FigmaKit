/**
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org/>
 */

import Foundation
import UIKit
import FigmaKit

class RegisterViewController: UIViewController {
    private(set) var imgBackground = UIImageView()
    private(set) var btnBack = UIButton(type: .system)
    private(set) var lblTitle = UILabel()
    private(set) var btnFacebook = DefaultButton(type: .system)
    private(set) var btnGoogle = DefaultButton(type: .system)
    private(set) var lblOr = UILabel()
    private(set) var tfUsername = InputField()
    private(set) var tfEmail = InputField()
    private(set) var tfPassword = InputField()
    private(set) var lblPrivacy = UILabel()
    private(set) var btnTick = UIButton()
    private(set) var btnGetStarted = DefaultButton(type: .system)
    
    private(set) var scrollView = UIScrollView()
    
    private let mainStack = UIStackView.vStack(spacing: 30)
    private let barStack = UIStackView.hStack()
    private let contentStack = UIStackView.vStack(spacing: 35)
    private let snsStack = UIStackView.vStack(spacing: 20)
    private let inputStack = UIStackView.vStack(spacing: 20)
    private let policyStack = UIStackView.hStack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTextFields()
        setupLabels()
        setupButtons()
        
        imgBackground.image = UIImage(named: "register_bg")
    }
    
    private func setupLayout() {
        view.addAutoHeightSubview(imgBackground)
        view.addFilledSubview(mainStack)
        mainStack.layoutMargins = .init(20)
        mainStack.isLayoutMarginsRelativeArrangement = true
        
        mainStack.addArrangedSubview(barStack)
        barStack.addArrangedSubview(btnBack)
        NSLayoutConstraint.activate([
            btnBack.widthAnchor.constraint(equalToConstant: 56),
            btnBack.heightAnchor.constraint(equalToConstant: 56)
        ])
        barStack.addSpacer()
        
        mainStack.addArrangedSubview(scrollView)
        
        scrollView.addFilledSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        contentStack.addArrangedSubview(lblTitle)
        contentStack.addArrangedSubview(snsStack)
        snsStack.addArrangedSubview(btnFacebook)
        snsStack.addArrangedSubview(btnGoogle)

        contentStack.addArrangedSubview(lblOr)
        contentStack.addArrangedSubview(inputStack)
        inputStack.addArrangedSubview(tfUsername)
        inputStack.addArrangedSubview(tfEmail)
        inputStack.addArrangedSubview(tfPassword)
        inputStack.addArrangedSubview(policyStack)
        
        policyStack.addArrangedSubview(lblPrivacy)
        policyStack.addSpacer()
        policyStack.addArrangedSubview(btnTick)

        mainStack.addArrangedSubview(btnGetStarted)
    }
    
    private func setupTextFields() {
        tfUsername.borderStyle = .none
        tfUsername
            .fill(.solid(0xF2F3F7))
            .corner(.all(15))
            .rightIcon = UIImage(named: "ic_tick")
        tfUsername.text = "afsar"
        
        tfEmail.borderStyle = .none
        tfEmail
            .fill(.solid(0xF2F3F7))
            .corner(.all(15))
            .rightIcon = UIImage(named: "ic_tick")
        tfEmail.text = "imshuvo97@gmail.com"
        
        tfPassword.borderStyle = .none
        tfPassword
            .fill(.solid(0xF2F3F7))
            .corner(.all(15))
            .rightIcon = UIImage(named: "ic_eye")
        tfPassword.text = "password"
        
        tfPassword.isSecureTextEntry = true
    }
    
    private func setupLabels() {
        lblTitle.typography(.system(weight: 700, style: .normal, size: 28, lineHeight: 37.8))
            .content("Create your account")
            .color(0x3F414E)
        lblTitle.textAlignment = .center
        
        lblOr.typography(.system(weight: 700, style: .normal, size: 14, lineHeight: 15.13, letter: 0.5))
            .content("OR LOG IN WITH EMAIL")
            .color(0xA1A4B2)
        lblOr.textAlignment = .center
        
        lblPrivacy
            .setDefault(.system(weight: 400, style: .normal, size: 14, lineHeight: 15.13, letter: 0.5), color: 0xA1A4B2)
            .add("i have read the ")
            .add("Privacy policy", color: 0x7583CA)
            .cleanUp()
            .numberOfLines = 1
    }
    
    private func setupButtons() {
        btnBack.setImage(UIImage(named: "ic_back"), for: .normal)
        btnBack.corner(.all(28)).stroke(.inside(0xEBEAEC, size: 1))

        btnFacebook
            .corner(.all(31))
            .fill(.solid(0x7583CA))
            
        btnFacebook.setTitleColor(0xF6F1FB.color, for: .normal)
        btnFacebook.setTitle("CONTINUE WITH FACEBOOK", for: .normal)
        btnFacebook.titleLabel?.typography(.system(weight: 400, style: .normal, size: 14, lineHeight: 15.13, letter: 0.5))
        btnFacebook.contentEdgeInsets = .init(top: 18, left: 0, bottom: 18, right: 0)
        btnFacebook.setImage(UIImage(named: "ic_facebook"))
        
        btnGoogle
            .corner(.all(31))
            .stroke(.inside(0xEBEAEC, size: 1))
        btnGoogle.setTitleColor(0x3F414E.color, for: .normal)
        btnGoogle.setTitle("CONTINUE WITH GOOGLE", for: .normal)
        btnGoogle.titleLabel?.typography(.system(weight: 400, style: .normal, size: 14, lineHeight: 15.13, letter: 0.5))
        btnGoogle.contentEdgeInsets = .init(top: 18, left: 0, bottom: 18, right: 0)
        btnGoogle.setImage(UIImage(named: "ic_google"))
        
        btnGetStarted
            .corner(.all(31))
            .fill(.solid(0x8E97FD))
            .setTitleColor(0xF6F1FB.color, for: .normal)
        
        btnGetStarted.setTitle("GET STARTED", for: .normal)
        btnTick.setImage(UIImage(named: "ic_square"), for: .normal)
    }
}

class InputField: UITextField {
    var rightIcon: UIImage? {
        didSet {
            self.rightViewMode = .always
            self.rightView = UIImageView(image: rightIcon)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 20)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 20)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 27
        return rect
    }
}

class DefaultButton: UIButton {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 62)
    }
    
    @discardableResult
    func setImage(_ image: UIImage?) -> Self {
        if let image = image {
            self.imageView?.contentMode = .center
            self.setImage(image, for: .normal)
            
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.contentHorizontalAlignment = .left
            self.titleEdgeInsets.left = (frame.width - (imageEdgeInsets.left + imageView!.frame.width) - titleLabel!.frame.width) / 2
            
            bringSubviewToFront(self.imageView!)
        }
        return self
    }
}
