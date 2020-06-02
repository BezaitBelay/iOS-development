//
//  MFMailComposeViewController.swift
//  ContactApp
//
//  Created by Dynamo Software on 18.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit
import MessageUI

class MailTableViewController: UITableViewController {
    
    var contactList = ContactBook.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let sortedList = contactList.sorted()
        cell.textLabel?.text = sortedList[indexPath.row].fullName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.setToRecipients([contactList[indexPath.row].email])
            mailComposeViewController.setSubject("Cheers!")
            
            present(mailComposeViewController,animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Not available!", message: "Mail services are not configured", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}
