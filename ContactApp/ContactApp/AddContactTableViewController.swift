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
    private let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var homeAddressTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!
    var pickerData = [Group.family.rawValue, Group.work.rawValue, Group.friends.rawValue]
    var contactGroup: Group?
    
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var saveEditButton: UIBarButtonItem!
    
    @IBOutlet var textFieldCollection: [UITextField]!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        createPickerView()
        updateFieldsContent()
        updateImageButtonText()
        addImageDelegate()
    }
    
    // MARK: - Action methods
    @IBAction func addPictureButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveEditButtonState()
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        if saveEditButton.title == "Edit" {
            updateFieldsEditablity(to: true)
            updateFieldsColor(to: .black)
            updateSaveEditButtonState()
            sender.title = "Save"
            changePhotoButton.isHidden = false
        } else {
            performSegue(withIdentifier: "SaveUnwind", sender: self)
        }
    }
    
    // MARK: - Private methods
    private func updateSaveEditButtonState() {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        saveEditButton.isEnabled = !firstName.isEmpty && !lastName.isEmpty && !phoneNumber.isEmpty && !email.isEmpty
    }
    
    private func updateFieldsColor(to color: UIColor) {
        for item in textFieldCollection {
            item.textColor = color
        }
    }
    
    private func updateFieldsEditablity(to flag: Bool) {
        for item in textFieldCollection {
            item.isEnabled = flag
        }
    }
    
    private func updateFieldsContent() {
        guard let contact = contact else {
            updateContentForEdit()
            return
        }
        
        updateFieldsEditablity(to: false)
        updateFieldsColor(to: .gray)
        changePhotoButton.isHidden = true
        
        contactPicture.image = contact.picture ?? UIImage(named: "img0")
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        phoneNumberTextField.text = contact.phoneNumber
        emailTextField.text = contact.email
        homeAddressTextField.text = contact.homeAddress
        groupTextField.text = contact.group.rawValue
        //groupPicker.selectRow(contact.group.number, inComponent: 0, animated: false)
    }
    
    private func updateContentForEdit() {
        saveEditButton.title = "Save"
        changePhotoButton.isHidden = false
        updateSaveEditButtonState()
    }
    
    private func image(image1: UIImage, isEqualTo image2: UIImage?) -> Bool {
        guard let data1 = image1.pngData(), let data2 = image2?.pngData() else { return false }
        return data1 == data2
    }
    
    private func updateImageButtonText(){
        if let picture = contact?.picture, image(image1: picture, isEqualTo: UIImage(named: "img0")) == false {
            changePhotoButton.setTitle("Change picture", for: .normal)
        }
        else {
            changePhotoButton.setTitle("Add picture", for: .normal)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveUnwind" && saveEditButton.title == "Save" else {return}
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phoneNumber = phoneNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let homeAddress = homeAddressTextField.text
        let currentContactGroup = contactGroup ?? Group.family
        
        contact = Contact(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email, homeAddress: homeAddress, picture: contactPicture.image, group: currentContactGroup )
        if let destination = segue.destination as? AllContactsTableViewController, let contact = contact{
            destination.contact = contact
        }
        
    }
}

// MARK: - UIImagePickerControllerDelegate

extension AddContactTableViewController: UIImagePickerControllerDelegate &  UINavigationControllerDelegate {
    
    private func addImageDelegate() {
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            contactPicture.contentMode = .scaleToFill
            contactPicture.image = pickedImage
            updateImageButtonText()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension AddContactTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        groupTextField.inputView = pickerView
    }
    
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
        contactGroup = Group(rawValue: pickerData[row])
        groupTextField.text = pickerData[row]
    }
}

// MARK: - UITextFieldDelegate

extension AddContactTableViewController: UITextFieldDelegate  {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
}
