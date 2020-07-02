//
//  ContactDetailCoordinator.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 15.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage
import MessageUI

class ContactDetailCoordinator: Coordinator {
    
    var rootNavigationController: UINavigationController?
    /*************************************/
    // MARK: - Coordinator
    /*************************************/
    
    init(navVC: BaseNavigationVC? = nil, contactId: String) {
        super.init()
        guard let contactDetailVC = ContactDetailVC.instantiateFromStoryboard() as? ContactDetailVC else { return }
        contactDetailVC.shouldFinishScene = true
        let contactDetailViewModel = ContactDetailViewModel(contactDetailRepository: ContactDetailRepository(), id: contactId)
        contactDetailViewModel.delegate = self
        contactDetailVC.viewModel = contactDetailViewModel
        guard let navVC = navVC else { return }
        self.rootNavigationController = navVC
        self.rootNavigationController?.pushViewController(contactDetailVC, animated: true)
    }
    
    override func start() {
        childCoordinators.first?.start()
    }
    
    override func finish() {
        //         Clean up your rootViewController or any data that will persist and remove self from parentCoordinator
    }
}

protocol ContactDetailCoordinatorDelegate: class {
    func openMailComposeViewController(propertyValue: String?)
}

extension ContactDetailCoordinator: ContactDetailCoordinatorDelegate {
    func openMailComposeViewController(propertyValue: String?) {
        MFMailComposeViewController.canSendMail() ? openMailComposer(with: propertyValue) : openAlertMailMessage()
    }
    
    // MARK: Private methods
    private func openAlertMailMessage() {
        let alert = UIAlertController(title: "Not available!", message: "Mail services are not configured", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        rootNavigationController?.present(alert, animated: true, completion: nil)
    }
    
    private func openMailComposer(with recipients: String?) {
        let mailComposeViewController = MFMailComposeViewController()
        if let recipients = recipients {
            mailComposeViewController.setToRecipients([recipients])
            mailComposeViewController.setSubject("Cheers!")
        }
        rootNavigationController?.present(mailComposeViewController, animated: true)
    }
}
