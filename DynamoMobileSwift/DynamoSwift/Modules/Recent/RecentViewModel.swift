//
//  RecentViewModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 17.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

class RecentsViewModel {
    var entities: UserDefaults
    
    init() {
        entities = UserDefaults.standard
        print(UserDefaults.standard.dictionaryRepresentation().values)
    }
}

extension RecentsViewModel: BaseDataSource {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return 1
    }
    
    func viewConfigurator(at index: Int, in setion: Int) -> ViewConfigurator? {
        return nil
    }
}
