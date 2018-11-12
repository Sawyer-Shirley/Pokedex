//
//  ViewController.swift
//  Pokedex
//
//  Created by Sawyer Shirley on 11/12/18.
//  Copyright © 2018 Sawyer Shirley. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var infoView: UITextView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var picView: UIImageView!
    
    let pokedexBasicLink = "https://pokeapi.co/api/v2/pokemon/"
    
    //All the variables that will store information about the pokemon
    var pokeId = ""
    var pokeName = ""
    var pokeAbilities = ""
    var pokeHeight = ""
    var pokeWeight = ""
    var pokeForms = ""
    var pokeArea = ""
    var pokeMoves = ""
    var pokeSpecies = ""
    var pokeStats = ""
    var pokeType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func submitButtonTapped(_ sender: Any) {
        //Dismissing Keyboard from view
        nameField.resignFirstResponder()
        
        //Checking to make sure nameField has a value
        guard let pokeName = nameField.text else {
                return
        }
        
        //Clearing out textfield
        nameField.text = ""
        
        //Replacing spaces with - so they can be used as part of the URL
        let nameURLComponent = pokeName.replacingOccurrences(of: " ", with: "-")
        
        //URL
        let requestURL = pokedexBasicLink + nameURLComponent + "/"
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.infoView.text = json["name"].stringValue
            case .failure(let error):
                self.infoView.text = "Invalid selection entered or an error occured. Try again."
                print(error.localizedDescription)
            }
        }
    }
}
