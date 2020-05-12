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
    
    @IBOutlet weak var labelc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             switch section {
                case 0:
                    let family = contactList.contacts.filter({$0.group == .family})
                    return family.count
        //        case 1:
        //            let work = contactList.contacts.filter({$0.group == .work})
        //            return work.count
        //        case 2:
        //            let friends = contactList.contacts.filter({$0.group == .friend})
        //            return friends.count
                default:
                    return 0
                }
    }
    

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            print(indexPath.row)
            print(indexPath.section)
            if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyCell", for: indexPath) as? FamilyContactTableViewCell
//                let family = contactList.contacts.filter({$0.group == .family})
//                let contact = family[indexPath.row]
//                if let image = contact.picture {
//                    familyImage.image = image.images?.first
//                }
//                familyNameLabel.text = contact.fullName
//                familyPhoneLabel.text = contact.phoneNumber
//                familyEmailLabel.text = contact.email
                
                return cell
            }
    //        if indexPath.section == 1 {
    //            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkCell", for: indexPath)
    //            let work = contactList.contacts.filter({$0.group == .work})
    //            let contact = work[indexPath.row]
    //            if let image = contact.picture {
    //                workImage.image = image.images?.first
    //            }
    //            workNameLabel.text = contact.fullName
    //            workPhoneLabel.text = contact.phoneNumber
    //            workEmailLabel.text = contact.email
    //            return cell
    //        }
    //        if indexPath.section == 2 {
    //            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath)
    //            let friends = contactList.contacts.filter({$0.group == .friend})
    //            let contact = friends[indexPath.row]
    //            if let image = contact.picture {
    //                friendsImage.image = image.images?.first
    //            }
    //            friendsNameLabel.text = contact.fullName
    //            friendsPhoneLabel.text = contact.phoneNumber
    //            friendsEmailLabel.text = contact.email
    //            return cell
    //        }
            return UITableViewCell()
        }

}
