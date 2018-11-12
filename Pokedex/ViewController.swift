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
        
        //Printing info into view
        Alamofire.request(requestURL).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.infoView.text = json.rawString()
                //All the variables that will store information about the pokemon
                var pokeId = json["id"].stringValue
                var pokeNames = json["name"].stringValue
                //Preparing format for organized info
                let format = """
Name: \(pokeNames.self)
                
Id: \(pokeId.self)

Stats:

Type:

Species:

Forms:

Height:

Weight:

Location:

Moves:

Abilities:

"""
                //self.infoView.text = format
            case .failure(let error):
                self.infoView.text = "Invalid selection entered or an error occured. Try again."
                print(error.localizedDescription)
            }
        }
    }
}
