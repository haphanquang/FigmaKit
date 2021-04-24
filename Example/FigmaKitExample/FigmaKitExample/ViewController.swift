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

import UIKit
import FigmaKit

class ViewController: UIViewController {
    private var sampleLabel = UILabel()
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
//        view.backgroundColor = UIColor.white.alpha(70)?.color
    }
    
    func configViews() {
        sampleButton.setTitle("Confirm", for: .normal)
    }

    func applySample() {
        topView
            .corner(.mixed(20, 50, 0, 50))
            .fill(.linear(colors: [(0xEBEBEB, 0), (0x9EE505, 1)], alpha: 90))
            .stroke(.inside("#FFFFFF".alpha(90), size: 5))
            .shadow(.drop(0x000000, x: 0, y: 4, b: 4, s: 0, alpha: 25))
        
        bottomView
            .corner(.mixed(20, 50, 0, 50))
            .fill(.linear(colors: [(0xEBEBEB, 0), (0x9EE505, 1)], alpha: 90))
            .stroke(.outside("#FFFFFF".alpha(90), size: 5))
            .shadow(.drop(0x000000, x: 0, y: 4, b: 4, s: 0, alpha: 25))
        
        sampleButton
            .corner(.all(12))
            .shadow(.drop(0x000000, x: 0, y: 4, b: 4, s: 0, alpha: 25))
            .padding(.init(16))
            .tint(0xffffff)
            .fill(
                .linear(
                    colors: [(0x00BF00, CGFloat(0)),
                             (0x0000BF, CGFloat(1))],
                    start: .init(x: 0.5, y: 0.5),
                    end: .init(x: 1, y: 1)
                )
            )
            
            .stroke(.center("#FFFFFF", size: 5))
            .typography(.custom(name: "Roboto", weight: 700, size: 18))
        
        view.fill(.solid("#GGFFAA"))
    }
    
    func applyRichText() {
        let normal = Typography.custom(name: "Roboto", weight: 400, size: 16)
        let bold = Typography.custom(name: "Roboto", weight: 700, size: 20)
        
        let foreground = 0x000000
        let green = 0x00FF00
        let grey = 0xCCCCCC
        
        sampleLabel
            
            // Mark default style
            .registerDefaults(typography: normal, color: foreground)
            
            .add("Lorem".normal(bold.font, color: grey))
            .add(" ipsum dolor sit".normal(normal.font, color: green))
            .add(" amet ")
            .add("consectetur adipiscing elit", style: .underlined)
            .add(", sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n")
            .add("Ut enim ad minim veniam", style: .strikeThrough)
            .add(" quis nostrud ".normal(bold.font, color: foreground, background: green))
            .add("exercitation", style: .link("https://google.com"))
            .add(" ullamco laboris nisi ut aliquip ex ea commodo ")
            .add("consequat.".normal(bold.font, color: 0xFF0000))
            
            // Label-wide applying should be done finally
            .alignment(.left)
            .lineSpacing(5)
            
            // Don't forget to clean for next use
            .unregister()
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
        stack.addArrangedSubview(bottomView)
        stack.addArrangedSubview(sampleButton)
        
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            topView.heightAnchor.constraint(equalToConstant: 100),
            bottomView.heightAnchor.constraint(equalToConstant: 100),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

