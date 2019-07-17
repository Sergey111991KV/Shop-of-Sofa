//
//  WelcomViewController.swift
//  Shop of  Sofa
//
//  Created by Сергей Косилов on 09/07/2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit
import Firebase

class WelcomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func logoutButton(_ sender: Any) {
       
        do{
           
            try Auth.auth().signOut()
        } catch{
            print(error)
        }
       
        
    }
    
}
