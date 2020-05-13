//
//  AllContactsTableViewController.swift
//  ContactApp
//
//  Created by Dynamo Software on 11.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class AllContactsTableViewController: UITableViewController {
    
    var splitContactList = [Group.family: ContactBook.shared.contacts.filter({$0.group == .family}),
                            Group.work: ContactBook.shared.contacts.filter({$0.group == .work}),
                            Group.friend: ContactBook.shared.contacts.filter({$0.group == .friend})]
    
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
            guard let family = splitContactList[Group.family] else { return 0 }
            return family.count
        case 1:
            guard let work = splitContactList[Group.work] else { return 0 }
            return work.count
        case 2:
            guard let friends = splitContactList[Group.friend] else { return 0 }
            return friends.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var initCell = UITableViewCell()
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyCell", for: indexPath) as! FamilyTableViewCell
            let family = splitContactList[Group.family] ?? [Contact]()
            let contact = family[indexPath.row]
            cell.updateFamilyContact(with: contact)
            initCell = cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCell", for: indexPath) as! WorkTableViewCell
            let work = splitContactList[Group.work] ?? [Contact]()
            let contact = work[indexPath.row]
            cell.updateWorkContact(with: contact)
            initCell = cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
            let friends = splitContactList[Group.friend] ?? [Contact]()
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
            switch indexPath.section {
            case 0: splitContactList[Group.family]?.remove(at: indexPath.row)
            case 1: splitContactList[Group.work]?.remove(at: indexPath.row)
            case 2: splitContactList[Group.friend]?.remove(at: indexPath.row)
            default: break
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
}
