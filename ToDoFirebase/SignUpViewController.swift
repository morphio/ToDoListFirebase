//
//  SignUpViewController.swift
//  ToDoFirebase
//
//  Created by Alex on 23.03.17.
//  Copyright © 2017 Grid. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var userImageView: ProfileImageView!
    @IBOutlet weak var usernameTextField: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTestField: CustomTextField!
    @IBOutlet weak var countryTextField: CustomTextField!
    fileprivate var pickerView : UIPickerView!
    var server = Server()
    
    fileprivate var countryArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        countryArray = NSLocale.isoCountryCodes.map { (code:String) -> String in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        }
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        countryTextField.inputView = pickerView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissController(gesture:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: - UIPickerViewDelegate -
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryTextField.text! = countryArray[row]
    }
    
    //MARK: - UIPickerViewDataSource -
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //MARK: - UIImagePickerControllerDelegate -
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        self.userImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = NSAttributedString(string: countryArray[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
        return title
    }
    
    
    //MARK: - Actions -
    @IBAction func signUpButton(_ sender: Any) {
        
        let data = UIImageJPEGRepresentation(self.userImageView.image!, 0.8)
        server.signUp(email: emailTextField.text!, username: usernameTextField.text!, password: passwordTestField.text!, country: countryTextField.text!, data: data! as NSData!)
    }
    
    @IBAction func choosePictureAction(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotoAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(savedPhotoAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    func dismissController(gesture: UITapGestureRecognizer) -> Void {
        self.view.endEditing(true)
    }
}
