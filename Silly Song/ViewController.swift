//
//  ViewController.swift
//  Silly Song
//
//  Created by Segun Famisa on 28/12/2016.
//  Copyright © 2016 Segun Famisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        lyricsView.text = ""
        nameField.text = ""
    }

    @IBAction func displayLyrics(_ sender: Any) {
        var lyrics = ""
        if let name = nameField.text {
            if !name.isEmpty {
                lyrics = lyricsForName(lyricsTemplate: template, fullName: name)
                
                // display lyrics
                lyricsView.text = lyrics
            }
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false;
    }
}



/****************************************
 * Pure functions for generating lyrics *
 ****************************************/

let template = "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>\n" +
    "Banana Fana Fo F<SHORT_NAME>\n" +
    "Me My Mo M<SHORT_NAME>\n" +
    "<FULL_NAME>"

/**
 *  This method finds the first vowel in the name and returns the index.
 *  The method returns 0 if no vowels are found.
 */
func findFirstVowel(_ name: String) -> Int {
    let vowelsSet = CharacterSet(charactersIn: "aeiou")
    
    var index = 0
    for character in name.unicodeScalars {
        if vowelsSet.contains(character) {
            // character is a vowel
            return index
        } else {
            index += 1
        }
    }
    return 0
}

/**
 *  This method creates a short name for the input name.
 *  It finds the index of the first vowel and creates a short name by substring
 *  from the index of the first vowel.
 */
func shortNameForName(name: String) -> String {
    let lowerCaseName = name.lowercased()
    var shortName = ""
    let index = lowerCaseName.index(lowerCaseName.startIndex, offsetBy: findFirstVowel(lowerCaseName))
    shortName = lowerCaseName.lowercased().substring(from: index)
    
    return shortName
}

/**
 *  This method creates lyrics for a certain name using the template specified
 *  above.
 */
func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameForName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics;
}
