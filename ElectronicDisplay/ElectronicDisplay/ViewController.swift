//
//  ViewController.swift
//  ElectronicDisplay
//
//  Created by 목정아 on 2023/06/23.
//

import UIKit

protocol SendDateDelegate : AnyObject {
    func sendData(name: String)
}

class ViewController: UIViewController {
    
    
    weak var delegate: SendDateDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

