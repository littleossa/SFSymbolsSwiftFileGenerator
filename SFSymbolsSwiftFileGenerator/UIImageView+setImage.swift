//
//  UIImage+Extension.swift
//  SFSymbolsSwiftFileGenerator
//
//  Created by 平岡修 on 2022/01/23.
//

import UIKit

extension UIImageView {
    
    enum Result: String {
        case success = "checkmark.circle.fill"
        case failure = "exclamationmark.triangle.fill"
        
        var image: UIImage {
            return UIImage(systemName: self.rawValue)!
        }
    }
    
    func setImage(byResult result: Result) {
        self.image = result.image
        self.tintColor = result == .success ? .systemBlue : .systemRed
    }
}
