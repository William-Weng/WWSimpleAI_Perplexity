# WWSimpleAI+Perplexity
[![Swift-5.7](https://img.shields.io/badge/Swift-5.7-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-16.0](https://img.shields.io/badge/iOS-16.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![TAG](https://img.shields.io/github/v/tag/William-Weng/WWSimpleAI_Perplexity) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- [Simply use the functionality of Perplexity AI.](https://www.perplexity.ai/)
- [簡單的使用Perplexity-AI功能](https://docs.perplexity.ai/api-reference/async-chat-completions-post)

![](./Example.png)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWSimpleAI_Perplexity.git", .upToNextMajor(from: "0.5.1"))
]
```

### 可用函式 (Function)
|函式|功能|
|-|-|
|configure(apiKey:model:)|[設定apiKey](https://www.perplexity.ai/account/)|
|chat(text:)|[執行聊天功能](https://docs.perplexity.ai/api-reference/async-chat-completions-post)|

### Example
```swift
import UIKit
import WWSimpleAI_Ollama
import WWSimpleAI_Perplexity

final class ViewController: UIViewController {
    
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    
    private let apiKey: String = "<YOUR_API_KEY>"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
}

private extension ViewController {
    
    func initSetting() {
        WWSimpleAI.Perplexity.shared.configure(apiKey: apiKey)
        chat(text: contentTextField.text)
    }
    
    func chat(text: String?) {
        
        guard let text else { return }
        
        Task {
            do {
                let text = try await WWSimpleAI.Perplexity.shared.chat(text: text).get()
                resultTextView.text = text
            } catch {
                print(error)
            }
        }
    }
}
```
