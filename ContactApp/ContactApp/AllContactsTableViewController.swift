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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            let family = contactList.contacts.filter({$0.group == .family})
            return family.count
        case 1:
            let work = contactList.contacts.filter({$0.group == .work})
            
            return work.count
        case 2:
            let friends = contactList.contacts.filter({$0.group == .friend})
            
            return friends.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        print(indexPath.section)
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyCell", for: indexPath) as! FamilyTableViewCell
            let family = contactList.contacts.filter({$0.group == .family})
            let contact = family[indexPath.row]
            cell.updateFamilyContact(with: contact)
            
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCell", for: indexPath) as! WorkTableViewCell
            let work = contactList.contacts.filter({$0.group == .work})
            let contact = work[indexPath.row]
            cell.updateWorkContact(with: contact)
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
            let friends = contactList.contacts.filter({$0.group == .friend})
            let contact = friends[indexPath.row]
            cell.updateFriendContact(with: contact)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Family"
        case 1: return "Work"
        case 2: return "Friends"
        default: return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contactList.removeAt(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMOde = tableView.isEditing
        tableView.setEditing(!tableViewEditingMOde, animated: true)
    }
    
}
