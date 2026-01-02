//
//  WWSimpleAI_Perplexity.swift
//  WWSimpleAI_Perplexity
//
//  Created by William.Weng on 2026/1/2.
//

import UIKit
import WWNetworking
import WWSimpleAI_Ollama

// MARK: - WWSimpleAI.Perplexity
extension WWSimpleAI {
    
    open class Perplexity {
        
        public static let shared = Perplexity()
        
        static let baseURL = "https://api.perplexity.ai"
        
        var apiKey = "<Key>"
        var model: Model = .default
        
        private init() {}
    }
}

// MARK: - 公開函式
public extension WWSimpleAI.Perplexity {
    
    /// [參數設定](https://docs.perplexity.ai/guides/search-quickstart)
    /// - Parameters:
    ///   - apiKey: String
    ///   - model: Perplexity模型
    func configure(apiKey: String, model: Model = .default) {
        self.apiKey = apiKey
        self.model = model
    }
    
    /// [執行聊天功能](https://docs.perplexity.ai/api-reference/async-chat-completions-post)
    /// - Parameter content: String
    /// - Returns: Result<String?, Error>
    func chat(text: String) async -> Result<String?, Error> {
        
        let api = API.chat
        let header = authorizationHeaders()
        let json = """
        {
            "model": "\(model.value())",
            "messages": [{"role": "user","content":"\(text)"}]
        }
        """
        
        let result = await WWNetworking.shared.request(httpMethod: .POST, urlString: api.value(), headers: header, httpBodyType: .string(json))
        
        switch result {
        case .success(let info): return parseChatInformation(info)
        case .failure(let error): return .failure(error)
        }
    }
}

// MARK: - 小工具
private extension WWSimpleAI.Perplexity {
    
    /// 解析回傳JSON文字
    /// - Parameter info: WWNetworking.ResponseInformation
    /// - Returns: Result<String?, Error>
    func parseChatInformation(_ info: WWNetworking.ResponseInformation) -> Result<String?, Error> {
        
        guard let jsonObject = info.data?._jsonObject(),
              let dictionary = jsonObject as? [String: Any]
        else {
            return .success(nil)
        }
        
        if let error = dictionary["error"] as? [String: Any] { return .failure(CustomError.error(error)) }
        let text = parseCandidatesText(dictionary)
        
        return .success(text)
    }
    
    /// 解析回傳內容
    /// => {"choices":[{"message":{"content":"<content>"}}]}
    /// - Parameter dictionary: [String: Any]
    /// - Returns: String?
    func parseCandidatesText(_ dictionary: [String: Any]) -> String? {
        
        guard let choices = dictionary["choices"] as? [Any],
              let choice = choices.first as? [String : Any],
              let message = choice["message"] as? [String: Any],
              let content = message["content"] as? String
        else {
            return nil
        }
        
        return content
    }
    
    /// 安全認證Header
    /// - Returns: [String: String?]
    func authorizationHeaders() -> [String: String?] {
        let headers: [String: String?] = ["Authorization": "Bearer \(apiKey)"]
        return headers
    }
}
