//
//  myTestVC.swift
//  SwiftyWords-170723
//
//  Created by Joachim Vetter on 25.07.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

class myTestVC: UIViewController {

    @IBOutlet weak var myPuzzleLabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myPuzzles = Bundle.main.path(forResource: "PuzzlesText", ofType: "txt") {
            if let myPuzzlesText = try? String(contentsOfFile: myPuzzles) {
                let finalPuzzleText = myPuzzlesText.components(separatedBy: "\n")
                myPuzzleLabel.text = myPuzzlesText
                //let joinedText = finalPuzzleText.joined(separator: "\n")
                //myPuzzleLabel.text = joinedText
                print(finalPuzzleText)
                labelColor()
            }
        }

    }

    @IBAction func changeTextButton(_ sender: Any) {
        myLabel.text = "Wow, I've been changed!"
        let myAC = UIAlertController(title: "Begrüßung", message: "Hallo Jochen", preferredStyle: .alert)
        present(myAC, animated: false)
        myAC.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: nil))
    }
    func labelColor() {
        let randomA:CGFloat = CGFloat(arc4random_uniform(256))
        let randomB:CGFloat = CGFloat(arc4random_uniform(256))
        let randomC:CGFloat = CGFloat(arc4random_uniform(256))
        myPuzzleLabel.backgroundColor = UIColor(red: randomA/255, green: randomB/255, blue: randomC/255, alpha: 1.0)
        
    }
   
}
