//
//  ContactsViewModelProtocol.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

protocol ContactsViewModelProtocol: BaseDataSource {
  //  var entities: Observable<[BaseEntityModel]> {get}
    var shouldShowLoading: Observable<Bool> {get set}
    var shouldShowNoRecentView: Observable<Bool> {get set}
}
