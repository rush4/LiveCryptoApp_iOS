//
//  Extension+String.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 13/02/24.
//

import Foundation

extension String {
    
    func stringByStrippingHTML() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        guard let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else { return self }
        return attributedString.string
    }
}
