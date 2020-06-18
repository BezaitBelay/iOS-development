//
//  LoadingTableViewCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 18.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
typealias LoadingCellConfigurator = BaseViewConfigurator<LoadingTableViewCell>
class LoadingTableViewCell: UITableViewCell, Configurable {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    func configureWith(_ data: Any?) {
        // No need this
        loadingView.startAnimating()
    }
}
