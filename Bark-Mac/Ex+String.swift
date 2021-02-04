//
//  Ex+String.swift
//  Bark-Mac
//
//  Created by 蒋惠 on 2021/2/4.
//

import Foundation

extension String {
    
    public var base64Encoded: String {
        guard let codingData = self.data(using: .utf8) else { return self }
        return codingData.base64EncodedString()
    }
    
    public var base64Decoded: String {
        guard let decryptionData =  Data.init(base64Encoded: self, options: .ignoreUnknownCharacters) else { return self }
        return String.init(data: decryptionData, encoding: .utf8) ?? self
    }
    
    public var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    public var urlDecoded: String {
        return self.removingPercentEncoding ?? ""
    }
}
