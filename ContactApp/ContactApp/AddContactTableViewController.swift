//
//  AddContactTableViewController.swift
//  ContactApp
//
//  Created by Dynamo Software on 13.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class AddContactTableViewController: UITableViewController {
    
    @IBOutlet weak var contactPicture: UIImageView!
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var homeAddressTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var groupPicker: UIPickerView!
    var pickerData = [String]()
    
    var contact: Contact?
    var contactGroup: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        addImageDelegate()
        addPhoneNumberTextFieldDelegate()
        updateSaveButtonState()
        connectDataToPicker()
    }
    
    @IBAction func addPictureButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phoneNumber = PhoneNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        saveButton.isEnabled = !firstName.isEmpty && !lastName.isEmpty && !phoneNumber.isEmpty && !email.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveUnwind" {
            let firstName = firstNameTextField.text ?? ""
            let lastName = lastNameTextField.text ?? ""
            let phoneNumber = PhoneNumberTextField.text ?? ""
            let email = emailTextField.text ?? ""
            let currentContactGroup = contactGroup ?? Group.family
            contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email, homeAddress: homeAddressTextField.text, picture: contactPicture.image, group: currentContactGroup )
            if let destination = segue.destination as? AllContactsTableViewController, let contact = contact{
                destination.contactList.append(contact: contact)
            }
        }
        
    }
    
    
    
}

// MARK: - UIImagePickerControllerDelegate

extension AddContactTableViewController: UIImagePickerControllerDelegate &  UINavigationControllerDelegate{
    
    func addImageDelegate() {
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            contactPicture.contentMode = .scaleToFill
            contactPicture.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension AddContactTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let index = pickerView.selectedRow(inComponent: 0)
        contactGroup = Group(rawValue: pickerData[index]) ?? Group.friends
    }
    
    func connectDataToPicker(){
        groupPicker.delegate = self
        groupPicker.dataSource = self
        
        pickerData = [Group.family.rawValue, Group.work.rawValue, Group.friends.rawValue]
    }
}

// MARK: - UITextFieldDelegate

extension AddContactTableViewController: UITextFieldDelegate  {
    
    func addPhoneNumberTextFieldDelegate(){
        PhoneNumberTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //guard let textField =
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
}
