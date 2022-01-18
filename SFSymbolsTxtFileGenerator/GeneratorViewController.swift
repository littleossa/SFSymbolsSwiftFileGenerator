//
//  ViewController.swift
//  SFSymbolsTxtFileGenerator
//
//  Created by 平岡修 on 2022/01/16.
//

import UIKit

class GeneratorViewController: UIViewController {
    
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
        let symbolsEnumCases = createSFSymbolsEnumCasesfromTxtFile()
        
        var contents: String = ""
        for symbolsEnumCase in symbolsEnumCases {
            contents += symbolsEnumCase + "\n"
        }
        let completedSFSymbolsFileContents = String(format: basicSFSymbolsFileContents, contents)
        exportSwiftFile(contents: completedSFSymbolsFileContents)
    }
    
    private func createSFSymbolsEnumCasesfromTxtFile() -> [String] {
        guard let fileURL = Bundle.main.url(forResource: "SFSymbols", withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileURL) else {
                  fatalError("fail to generate")
              }
        return fileContents.splitIntoEnumCases()
    }
    
    private func exportSwiftFile(contents: String) {
        let path = NSHomeDirectory() + "/Documents/SFSymbols.swift"
        do {
            try contents.write(toFile: path, atomically: true, encoding : String.Encoding.utf8)
            print("Success to save:\n open \(path)")
            
        } catch let error as NSError {
            print("Fail to save: \(error)" )
        }
    }
}
