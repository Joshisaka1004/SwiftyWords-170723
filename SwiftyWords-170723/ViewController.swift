//
//  ViewController.swift
//  SwiftyWords-170723
//
//  Created by Joachim Vetter on 23.07.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    
    @IBOutlet weak var myStackView: UIStackView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var answersLabel: UILabel!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
        
    }
    var level = 1
    var myWordButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in myStackView.subviews {
            for j in i.subviews {
                let buttons = j as! UIButton
                myWordButtons.append(buttons)
                buttons.addTarget(self, action: #selector(changeBackground), for: .touchUpInside)
            }
        }
        loadLevel()
    }
    
    func loadLevel() {
        var cluesString = ""
        var solutionString = ""
        var wortFragmente = [String]()
        // (1) Wir durchsuchen den Hauptpfad unserer App (Bundle ist die Gesamtheit aller mit unserer App verbundenen Daten/Dateien) nach einer Datei namens Level xxx (xxx=Integer) vom Datentyp txt. Wir prüfen also, ob es im gesamten App-Bundle eine Datei namens Levelxxx.txt existiert, wobei xxx für eine Zahl vom Typ Integer steht, die den jeweiligen Level spezifiziert.
        if let levelPath = Bundle.main.path(forResource: "level\(level)", ofType: "txt") {
            // (2) Wenn oben diese Datei gefunden wurde, versuchen wir, aus dem GESAMTEN Inhalt dieser (Text-)Datei einen einzigen String zu machen. Aus diesem String machen wir schließlich einen Array von Substrings, die Trennung des Strings in Substrings erfolgt gemäß eines Separators, in unserem Fall ist dies die neue Zeile.
            if let inhalt = try? String(contentsOfFile: levelPath) {
                let gesamtInhalt = inhalt.components(separatedBy: "\n")
                let myShuffling = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: gesamtInhalt) as! [String]
                for (index,val) in myShuffling.enumerated() {
                    let temp1 = val.components(separatedBy: ": ")
                    cluesString += "\(index + 1). \(temp1[1])\n"
                    let temp2 = temp1[0].replacingOccurrences(of: "|", with: "")
                    solutionString += "\(temp2.count) letters\n"
                    solutions.append(temp2)
                    let teile = temp1[0].components(separatedBy: "|")
                    wortFragmente += teile
                }
                //print(wortFragmente)
            }
        }
        //print("www \(solutionString)")
        cluesLabel.text = cluesString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        let shuffledWortFragmente = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: wortFragmente) as! [String]
        if myWordButtons.count == wortFragmente.count {
            for j in 0..<myWordButtons.count {
                myWordButtons[j].setTitle("\(shuffledWortFragmente[j])", for: .normal)
            }
        }
        
    }
    
    
    @objc func changeBackground(buttons: UIButton) {
        if currentAnswer.text != nil, let hisCurrentAnswer = buttons.titleLabel!.text {
            currentAnswer.text = currentAnswer.text! + hisCurrentAnswer
            activatedButtons.append(buttons)
            buttons.isHidden = true
        }
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        if let solutionPosition = solutions.index(of: "\(currentAnswer.text!)") {
            activatedButtons.removeAll()
            var splitClues = answersLabel.text!.components(separatedBy: "\n")
            splitClues[solutionPosition] = "\(currentAnswer.text!)"
            answersLabel.text = splitClues.joined(separator: "\n")
            score += 1
            //scoreLabel.text = "Score: \(score)"
            currentAnswer.text = ""
        }
        if score % 7 == 0 && score > 0 {
            let myAC = UIAlertController(title: "SOLVED", message: "All levels over", preferredStyle: .alert)
            myAC.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(myAC, animated:  true)
        }
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        for j in 0..<activatedButtons.count {
            activatedButtons[j].isHidden = false
        }
        activatedButtons.removeAll()
    }
  
}
