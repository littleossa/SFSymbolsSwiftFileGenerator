//
//  ViewController.swift
//  SFSymbolsTxtFileGenerator
//
//  Created by 平岡修 on 2022/01/16.
//

import UIKit

class ViewController: UIViewController {
    
    let basicSFSymbolsFileContents: String = """
import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exportSFSymbolsSwiftFileFromSymbolNamesTxtFile()
    }
    
    private func exportSFSymbolsSwiftFileFromSymbolNamesTxtFile() {
        let sfsymbolsEnumCases = createSFSymbolsEnumCasesfromTxtFile()
        
        var contents: String = ""
        for sfsymbolsEnumCase in sfsymbolsEnumCases {
            contents += sfsymbolsEnumCase + "\n"
        }
        let sfSymbolsFileWithBody = String(format: basicSFSymbolsFileContents, contents)
        exportSwiftFile(withText: sfSymbolsFileWithBody)
    }
    
    private func createSFSymbolsEnumCasesfromTxtFile() -> [String] {
        guard let fileURL = Bundle.main.url(forResource: "SFSymbols", withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileURL) else {
                  fatalError("fail to generate")
              }
        return fileContents.splitIntoEnumCases()
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
