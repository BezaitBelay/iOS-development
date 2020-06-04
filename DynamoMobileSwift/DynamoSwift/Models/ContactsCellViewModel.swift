//
//  ContactsCellViewModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 4.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

struct ContactsCellViewModel {
    var id: String
      var es: String
    var url: URL
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageData = try? Data(contentsOf: url) else {
            return
        }
        let image = UIImage(data: imageData)
        DispatchQueue.main.async {
            completion(image)
        }
    }
}
