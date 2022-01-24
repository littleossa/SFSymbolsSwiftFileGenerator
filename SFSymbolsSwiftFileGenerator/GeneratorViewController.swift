//
//  GeneratorViewController.swift
//  SFSymbolsSwiftFileGenerator
//
//  Created by littleossa on 2022/01/16.
//
//  enjoy!

import UIKit

class GeneratorViewController: UIViewController {
    
    @IBOutlet private weak var resultImageView: UIImageView!
    
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
        
        exportSFSymbolsSwiftFile()
    }
    
    private func exportSFSymbolsSwiftFile() {
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
              let fileContents = try? String(contentsOf: fileURL, encoding: .utf8) else {
                  fatalError("Failure to generate")
              }
        return fileContents.splitIntoEnumCases()
    }
    
    private func exportSwiftFile(contents: String) {
        let path = NSHomeDirectory() + "/Documents/SFSymbols.swift"
        do {
            try contents.write(toFile: path, atomically: true, encoding : .utf8)
            resultImageView.setImage(byResult: .success)
            print("Success to write:\n open \(path)")
            
        } catch let error as NSError {
            resultImageView.setImage(byResult: .failure)
            print("Failure to write: \(error)" )
        }
    }
}
