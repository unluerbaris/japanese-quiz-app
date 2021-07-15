//
//  LessonsViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/09.
//

import UIKit

class LessonsViewController: UIViewController {
    
    // TODO: Change this after creating database
    @IBOutlet weak var lessonOneButton: WhiteBorderButton!
    
    let seeds = Seeds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seeds.seedData()
        
//        if seeds.getQuizArray()[0].isSuccessful {
//            lessonOneButton.layer.borderColor = #colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1)
//            lessonOneButton.setTitleColor(#colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1), for: .normal)
//        }
    }
    
    @IBAction func lessonButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToLesson", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
