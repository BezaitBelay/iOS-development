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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            let family = contactList.getContactListBy(group: .family)
            return family.count
        case 1:
            let work = contactList.getContactListBy(group: .work)
            return work.count
        case 2:
            let friends = contactList.getContactListBy(group: .friends)
            return friends.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var initCell = UITableViewCell()
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyCell", for: indexPath) as! FamilyTableViewCell
            let family = contactList.getContactListBy(group: .family)
            let contact = family[indexPath.row]
            cell.updateFamilyContact(with: contact)
            initCell = cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCell", for: indexPath) as! WorkTableViewCell
            let work = contactList.getContactListBy(group: .work)
            let contact = work[indexPath.row]
            cell.updateWorkContact(with: contact)
            initCell = cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
            let friends = contactList.getContactListBy(group: .friends)
            let contact = friends[indexPath.row]
            cell.updateFriendContact(with: contact)
            initCell = cell
        }
        return initCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return Group.family.rawValue
        case 1: return Group.work.rawValue
        case 2: return Group.friends.rawValue
        default: return ""
        }
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
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditContactSegue" {
            guard let navDestination = segue.destination as? UINavigationController else {return}
            guard let destination = navDestination.topViewController as? AddContactTableViewController else {return}
            let indexPath = tableView.indexPathForSelectedRow!
            destination.contact = contactList.getContactBy(indexPath: indexPath)
        }
    }
    
}
