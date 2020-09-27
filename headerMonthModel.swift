//
//  headerMonthModel.swift
//  LiliumPersonalFinanace
//
//  Created by Amin on 6/31/1399 AP.
//

import Foundation

class MonthHeader:Identifiable,Equatable {
    static func == (lhs: MonthHeader, rhs: MonthHeader) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    var isSelected:Bool
    var date:Date
    
    init(isSelected:Bool,date:Date) {
        self.isSelected = isSelected
        self.date = date
    }
}

struct MyData:Identifiable {
   
    
    let id = UUID()
    let array = [1,2,3]
}
