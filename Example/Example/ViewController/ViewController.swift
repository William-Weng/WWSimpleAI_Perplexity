//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2025/10/29.
//

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
