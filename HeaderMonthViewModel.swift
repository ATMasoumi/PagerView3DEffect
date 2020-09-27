//
//  HeaderMonthViewModel.swift
//  ViewPagerSwiftui
//
//  Created by Amin on 7/2/1399 AP.
//

import SwiftUI
import Combine


class monthHeaderViewModel:ObservableObject {
    
    @Published var index = Calendar.current.component(.month, from: Date()) {
        didSet(newValue){
            clearSelected()
            months[index].isSelected = true
        }
    }
    @Published var tabIndex = 2
    var currentDate = Date()
    @Published var months:[MonthHeader] = []
    
    init() {
        months.append(MonthHeader(isSelected: false, date: nextMonth(date: Date(), byAdding: 2)))
        months.append(MonthHeader(isSelected: false, date: nextMonth(date: Date(), byAdding: 1)))
        months.append(MonthHeader(isSelected: true, date: nextMonth(date: Date(), byAdding: 0)))
        months.append(MonthHeader(isSelected: false, date: nextMonth(date: Date(), byAdding: -1)))
        months.append(MonthHeader(isSelected: false, date: nextMonth(date: Date(), byAdding: -2)))
        
        let i = months.firstIndex { (item) -> Bool in
            item.isSelected == true
        }
        index = i!

    }
    func tapped(on item:MonthHeader) {
        select(item)
        
    }
    func clearSelected() {
        let i = months.firstIndex{ $0.isSelected == true }!
        months[i].isSelected = false
    }
    func select(_ item : MonthHeader) {
        
        if item.date > months[index].date {
            
            increaseDate()
        }else {
           
            decreaseDate()
        }
    }
    
    func increaseDate() {
        print("Increased")
       
        index -= 1
        months.removeLast()
        let selectedMonth = months.first!
        let nextDate = nextMonth(date: selectedMonth.date, byAdding: 1)
        let month = MonthHeader(isSelected: false, date: nextDate)
        months.insert(month, at: 0)
        index += 1
    }
    func decreaseDate() {
        print("Decreased")
        index += 1
        months.removeFirst()
        let selectedDate = months.last!
        let nextDate = nextMonth(date: selectedDate.date, byAdding: -1)
        let month = MonthHeader(isSelected: false, date: nextDate)
        months.insert(month, at: months.count)
        index -= 1
        
    }
    func nextMonth(date:Date,byAdding:Int) -> Date {
        var dayComponent    = DateComponents()
        dayComponent.month    = byAdding // For removing one day (yesterday): -1
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: date)
        return nextDate!
    }
    
    let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
        formatter.dateFormat = "MMM YYY"
           return formatter
       }()

    func title(date:Date) -> String {
        dateFormatter.string(from: date)
    }

}
