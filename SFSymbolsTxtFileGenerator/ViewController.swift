//
//  ViewController.swift
//  SFSymbolsTxtFileGenerator
//
//  Created by 平岡修 on 2022/01/16.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sfsymbolsNnumCases = createSFSymbolsNnumCases(version: "3_2")
        let sfSymbolsFile: String = """
import Foundation

enum SFSymbol: String, CaseIterable {

%@
}

extension UIImage {

convenience init?(symbol: SFSymbol) {
self.init(systemName: symbol.rawValue)
}

convenience init?(symbol: SFSymbol, with configuration: UIImage.Configuration?) {
self.init(systemName: symbol.rawValue, withConfiguration: configuration)
}
}
"""
        
        var contents: String = ""
        for sfsymbolsNnumCase in sfsymbolsNnumCases {
            contents += sfsymbolsNnumCase + "\n"
        }
        let sfSymbolsFileWithBody = String(format: sfSymbolsFile, contents)
        exportSwiftFile(withText: sfSymbolsFileWithBody)
    }
    
    private func createSFSymbolsNnumCases(version: String) -> [String] {
        guard let fileURL = Bundle.main.url(forResource: "SFSymbols" + version, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileURL) else {
                  fatalError("fail to generate")
              }
        return fileContents.split(separator: "\n").compactMap { symbolName in
            
            if symbolName.isEmpty { return nil }
            
            return "case \(String(symbolName).lowerCamelCase()) = \"\(String(symbolName))\""
        }
    }
    
    private func exportSwiftFile(withText text: String) {
        let path = NSHomeDirectory() + "/Documents/SFSymbols.swift"
        do {
            try text.write(toFile: path, atomically: true, encoding : String.Encoding.utf8)
            print("Success to save:\n open \(path)")
            
        } catch let error as NSError {
            print("Fail to save: \(error)" )
        }
    }
}

extension String {
    
    func lowerCamelCase() -> String {
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
