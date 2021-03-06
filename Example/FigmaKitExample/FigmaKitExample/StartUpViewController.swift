// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
//
// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// For more information, please refer to <http://unlicense.org/>

import UIKit
import FigmaKit

class StartUpViewController: UIViewController {
    private var sampleLabel = UILabel()
    private var codeLabel = UILabel()
    private var topView = UIView()
    private var bottomView = UIView()
    private var sampleButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        layoutSampleViews()
        configViews()
        applyRichText()
        applySample()
    }
    
    func configViews() {
        sampleButton.setTitle("Register 👈🏻", for: .normal)
        sampleButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        codeLabel.text = "9000   1234   5678   1234"
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }

    func applySample() {
        topView
            .corner(.mixed(20, 50, 0, 50))
            .fill(.linear(colors: [(0xEBEBEB, 0), (0x9EE505, 1)], alpha: 90))
            .stroke(.inside("#FFFFFF".alpha(90), size: 5))
            .shadow(.drop(0x000000, x: 0, y: 4, b: 4, s: 0, alpha: 25))
        
        bottomView
            .corner(.mixed(0, 0, 5, 5))
            .fill(.solid(0xFFFFFF, 50))
            .stroke(.outside(0x11111, size: 1))
        
        sampleButton
            .corner(.all(12))
            .shadow(.drop(0x000000, x: 0, y: 4, b: 4, s: 0, alpha: 25))
            .padding(.init(16))
            .tint(0xFFFFFF)
            .fill(
                .linear(
                    colors: [(0x9EE505, 0),
                             (0xFFAABB, 1)],
                    start: .init(x: 0.5, y: 0),
                    end: .init(x: 0.5, y: 1)
                )
            )
            .stroke(.center("#FFFFFF", size: 1))
            .typography(.custom("Roboto", weight: 900, style: .normal, size: 20, letter: 0))
        
        view.fill(.solid("#GGFFAA"))
    }
    
    func applyRichText() {
        let normal = Typography.custom("Roboto", weight: 400, size: 16, lineHeight: 21, letter: 1)
        let bold = Typography.custom("Roboto", weight: 700, style: .normal, size: 20)
        
        let foreground = 0x000000
        let green = 0x00FF00
        let grey = 0xCCCCCC
        
        sampleLabel
            
            // Mark default style
            .setDefault(normal, color: foreground)
            
            .add("Lorem", typography: bold, color: grey)
            .add(" ipsum dolor sit", typography: normal, color: green)
            .add(" amet ")
            .add("consectetur adipiscing elit", style: .underlined)
            .add(", sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n")
            .add("Ut enim ad minim veniam", style: .strikeThrough)
            .add(" quis nostrud ", typography: bold, color: foreground, background: green)
            .add("exercitation", style: .link("https://google.com"))
            .add(" ullamco laboris nisi ut aliquip ex ea commodo ")
            .add("consequat.", typography: bold, color: grey)
            
            // Label-wide applying should be done finally
            .alignment(.left)
            
            // Don't forget to clean for next use
            .cleanUp()
        
        let typo = Typography.custom(
            "Roboto",
            weight: 500,
            style: .italic,
            size: 13,
            lineHeight: 15.23,
            letter: 2)
        
        codeLabel
            .typography(typo)
            .alignment(.center)
    }

    func layoutSampleViews() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        stack.isLayoutMarginsRelativeArrangement = true

        stack.addArrangedSubview(topView)
        stack.addArrangedSubview(sampleLabel)
        stack.addArrangedSubview(codeLabel)
        stack.addArrangedSubview(bottomView)
        stack.addArrangedSubview(sampleButton)
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            topView.heightAnchor.constraint(equalToConstant: 100),
            bottomView.heightAnchor.constraint(equalToConstant: 30),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func buttonDidTap(_ sender: UIButton) {
        print(sender)
        showRegisterVC()
    }
    
    private func showRegisterVC() {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
}

extension StartUpViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let navVc = navigationController {
          return navVc.viewControllers.count > 1
        }
        return false
    }
}
