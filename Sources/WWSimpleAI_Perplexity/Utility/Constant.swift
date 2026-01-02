//
//  Constant.swift
//  WWSimpleAI_Perplexity
//
//  Created by William.Weng on 2026/1/2.
//

import UIKit
import WWSimpleAI_Ollama

// MARK: - enum
public extension WWSimpleAI.Perplexity {
    
    /// API功能
    enum API {
        
        case chat           // 聊天問答
        case search         // 圖片辨識功能
        
        /// 取得url
        /// - Returns: String
        func value() -> String {
            
            let api: String
            
            switch self {
            case .chat: api = "chat/completions"
            case .search: api = "search"
            }
            
            return "\(WWSimpleAI.Perplexity.baseURL)/\(api)"
        }
    }
    
    /// [Perplexity模型](https://docs.perplexity.ai/getting-started/models)
    enum Model {
        
        case `default`
        case pro
        case custom(_ model: String)
        
        /// 取得模型名稱
        /// - Returns: String
        func value() -> String {
            
            let model: String
            
            switch self {
            case .default: model = "sonar"
            case .pro: model = "sonar-pro"
            case .custom(let _model): model = _model
            }
            
            return model
        }
    }
    
    /// Gemini錯誤
    enum CustomError: Error {
        case error(_ error: [String: Any])
    }
}
