//
//  RequestService.swift
//  Bark-Mac
//
//  Created by 蒋惠 on 2021/2/4.
//

import Foundation

struct RequestService {
    
    static func makeUrl(token: String, title: String, save: Bool = false, copy: Bool = false, url: String = "") -> String {
        var result = "https://api.day.app/\(token)/\(title)"
        var param: [String] = []
        if save {
            param.append("isArchive=1")
        }
        if copy {
            param.append("automaticallyCopy=1")
        }
        if !url.isEmpty {
            param.append("url=\(url)")
        }
        let paramStr = param.joined(separator: "&")
        if !paramStr.isEmpty {
            result += "?\(paramStr)"
        }
        return result.urlEncoded
    }
    
    static func sendRequest(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        let req = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: req)
        dataTask.resume()
    }
}
