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
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var answersLabel: UILabel!
    var score = 0
    var level = 1
    var myWordButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for eachSubview in view.subviews where eachSubview.tag == 1001 {
            let buttons = eachSubview as! UIButton
            myWordButtons.append(buttons)
            buttons.addTarget(self, action: #selector(changeBackground), for: .touchUpInside)
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
            let inhalt = try? String(contentsOfFile: levelPath)
            let gesamtInhalt = inhalt!.components(separatedBy: "\n")
            print(gesamtInhalt)
        }
    }
    
    @objc func changeBackground(buttons: UIButton) {
        view.backgroundColor = UIColor.yellow
    }
    
    @IBAction func submitTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
      
    }
}

