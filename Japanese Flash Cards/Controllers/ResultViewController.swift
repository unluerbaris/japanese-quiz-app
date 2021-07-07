//
//  ResultViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/06.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var resultValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "\(resultValue!)%"
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
