//
//  AuthViewController.swift
//  Shop of  Sofa
//
//  Created by Сергей Косилов on 11/07/2019.
//  Copyright © 2019 Сергей Косилов. All rights reserved.
//

import UIKit
import Firebase
class AuthViewController: UIViewController {

    
    //MARK: -Property
    var signup:Bool = true{
        willSet{
            if newValue{
                titleLabel.text = "Регистрация"
                enterButton.setTitle("Войти", for: .normal)
                nameTextField.isHidden = false
                registrationButton.isHidden = false
            }else{
                 titleLabel.text = "Вход"
                 enterButton.setTitle("Регистрация", for: .normal)
                nameTextField.isHidden = true
                registrationButton.isHidden = true
            }
        }
    }
    
    //MARK: - Outlets
    
    @IBOutlet weak var linkButtons: UIStackView!
    @IBOutlet weak var scrollAutenfication: UIScrollView!
    @IBOutlet weak var visialEffect: UIVisualEffectView!
    
    
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
    @IBOutlet weak var firstLinkButton: UIButton!
    @IBOutlet weak var secondLinkButton: UIButton!
    @IBOutlet weak var thirdLinkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self
        registerForKeyboardNotifications()
        

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(oneTapInView(_:)))
        singleTap.cancelsTouchesInView = false
        singleTap.numberOfTapsRequired = 1
        scrollAutenfication.addGestureRecognizer(singleTap)
        
        
    }
   
    @objc func  oneTapInView(_ recognizer: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
         mailTextField.resignFirstResponder()
         passwordTextField.resignFirstResponder()
    }
    
    
    @IBAction func entranceButton(_ sender: UIButton) {
        signup = !signup
    }
    
    func showAlertEmpty(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
   

}


extension AuthViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let email = mailTextField.text!
        let name = nameTextField.text!
        let password = passwordTextField.text!
        
        if (signup){
            if(!password.isEmpty && !name.isEmpty && !email.isEmpty){
                print("her")
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
             //       print("\(error)")
                    if error == nil{
                        if let result = result{
                            print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name" : name, "email": email])
                            self.dismiss(animated: true, completion: nil)
                            
                        }
                    }
                }
            }else{
                showAlertEmpty()
            }
            if(!password.isEmpty && !email.isEmpty){
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error == nil{
                       self.dismiss(animated: true, completion: nil)
                    }
                }
            
        }else{
            showAlertEmpty()
               
        }
}
        return true
}
}
extension AuthViewController {
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        //keyboardWillShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo else { return }
        guard let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        guard  linkButtons.isHidden == false else { return}
        linkButtons.isHidden = true
        let keyboardFrame = keyboardFrameValue.cgRectValue
       
        let contentInsets = keyboardFrame.height
        scrollAutenfication.contentInset.bottom += contentInsets
        scrollAutenfication.contentInset.top -= contentInsets/2
        scrollAutenfication.scrollIndicatorInsets.bottom += contentInsets
       
     
    }

    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
         linkButtons.isHidden = false
        scrollAutenfication.contentInset = contentInsets
        scrollAutenfication.scrollIndicatorInsets = contentInsets
    }
}

