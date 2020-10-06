//
//  ViewController.swift
//  Expences
//
//  Created by Yaroslav Luchyt on 06.10.2020.
//

import UIKit

class ViewController: UIViewController {
    
    var expences: Expences?
    //var jsonParser: JSONParserProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getExpences()
        
    }
    
    func getExpences() {
        JSONParser.parse() {[weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let expences):
                    self.expences = expences
                    print(self.expences)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

