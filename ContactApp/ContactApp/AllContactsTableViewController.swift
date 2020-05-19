//
//  AllContactsTableViewController.swift
//  ContactApp
//
//  Created by Dynamo Software on 11.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class AllContactsTableViewController: UITableViewController {
    
    var contactList = ContactBook.shared
    var contact: Contact?
    let headerTitles = [Group.family.rawValue, Group.work.rawValue, Group.friends.rawValue]
    
    @IBOutlet weak var addContactButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContactButton.isHidden = true
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ContactBook.shared.splitContactsInGroups().count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactBook.shared.splitContactsInGroups()[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllContactCell", for: indexPath) as? AllContactTableViewCell else {return UITableViewCell()}
        let contactListByGroup = contactList.getContactListBy(group: contactList[indexPath].group)
        let contact = contactListByGroup[indexPath.row]
        cell.updateContact(with: contact)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contactList.removeAt(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Action methods
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        addContactButton.isHidden = tableViewEditingMode
        if tableViewEditingMode == true {
            editButton.title = "Edit"
        } else {
            editButton.title = "Done"
        }
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    @IBAction func unwindFromAddContact(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveUnwind", let contact = contact else { return }
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            contactList[selectedIndexPath] = contact
        } else {
            contactList.append(contact: contact)
        }
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditContactSegue" {
            guard let navDestination = segue.destination as? UINavigationController else {return}
            guard let destination = navDestination.topViewController as? AddContactTableViewController else {return}
            let indexPath = tableView.indexPathForSelectedRow!
            destination.contact = contactList.getContactBy(indexPath: indexPath)
        }
    }
    
}
