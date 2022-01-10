//
//  PageModel.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 18.12.2021.
//

import Foundation
import UIKit

struct PageModel {
    var imagename: String
    var header: String
    var description: String
    
    var image: UIImage? {
        return UIImage(named: imagename)
    }
}
