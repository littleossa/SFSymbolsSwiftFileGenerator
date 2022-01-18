//
//  String+Extensions.swift
//  SFSymbolsTxtFileGenerator
//
//  Created by 平岡修 on 2022/01/18.
//

import Foundation

extension String {
    
    func splitIntoEnumCases() -> [String] {
        return self.split(separator: "\n").compactMap { symbolName in
            
            if symbolName.isEmpty { return nil }
            
            var enumCaseName = String(symbolName).lowerCamelCase()
            
            switch enumCaseName {
            case "case":
                enumCaseName = "`case`"
            case "return":
                enumCaseName = "`return`"
            case "repeat":
                enumCaseName = "`repeat`"
            default:
                if let initialIsNumber = enumCaseName.first?.isNumber,
                   initialIsNumber {
                    enumCaseName = "_" + enumCaseName
                }
            }
            
            return "case \(enumCaseName) = \"\(String(symbolName))\""
        }
    }
    
    private func lowerCamelCase() -> String {
        let separatedCharacters = self.components(separatedBy: ".")
        var optimalString = ""
        for i in 0..<separatedCharacters.count {
            if i == 0 {
                optimalString = separatedCharacters[i]
                continue
            }
            optimalString += separatedCharacters[i].capitalizeFirstLetter()
        }
        return optimalString
    }
    
    private func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.dropFirst()
    }
}

