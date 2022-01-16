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
        
        let sfsymbols = createSFSymbolsClassFile(version: "3_2")
        print(sfsymbols)
    }
    
    private func createSFSymbolsClassFile(version: String) -> [String] {
        guard let fileURL = Bundle.main.url(forResource: "SFSymbols" + version, withExtension: "txt"),
              let fileContents = try? String(contentsOf: fileURL) else {
                  fatalError("fail to generate")
              }
        return fileContents.split(separator: "\n").compactMap { $0.isEmpty ? nil : String($0) }
    }
}
