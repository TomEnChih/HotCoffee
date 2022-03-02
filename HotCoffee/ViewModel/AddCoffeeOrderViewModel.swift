//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by 董恩志 on 2022/3/1.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    var email: String?
    
    var selectedSize: String?
    var selectedType: String?
    
    #warning("capitalized 不太懂")
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
}
