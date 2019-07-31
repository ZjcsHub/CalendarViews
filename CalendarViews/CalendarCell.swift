//
//  CalendarCell.swift
//  OplayerSport
//
//  Created by App005 SYNERGY on 2019/7/24.
//  Copyright © 2019 App005 SYNERGY. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weekendLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    let selectColor = UIColor.red
    
    let globalTextColor = ThemeColor.globalTextColor
    
    var selectDate:Date? {
        didSet {
            guard let date = self.selectDate else { return }
            dayLabel.text = String(format: "%ld", date.day)
            weekendLabel.text = self.getWeekendString(week: date.weekday)
            monthLabel.text = self.getMonthString(month: date.month)
            let result = date.isEarlyThan(date: Date())
            let textColor = (result == ComparisonResult.orderedDescending) ? UIColor.gray : globalTextColor
            
            dayLabel.textColor = textColor
            weekendLabel.textColor = textColor
            monthLabel.textColor = textColor
            
        }
    }
    
    
    override var isSelected: Bool {
        didSet{
            
            if isSelected {
                dayLabel.textColor = selectColor
                weekendLabel.textColor = selectColor
                monthLabel.textColor = selectColor
            }else{
                
                dayLabel.textColor = globalTextColor
                weekendLabel.textColor = globalTextColor
                monthLabel.textColor = globalTextColor
                
            }
            
        }
    }
    
    func changeColor(isSelect:Bool) {
        
        let textColor:UIColor = isSelect ? selectColor : globalTextColor
        
        dayLabel.textColor = textColor
        weekendLabel.textColor = textColor
        monthLabel.textColor = textColor
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    private func getMonthString(month:Int) -> String {
        var monthString:String!
        switch month {
        case 1:
            monthString = NSLocalizedString("January", comment: "")
        case 2:
            monthString = NSLocalizedString("February", comment: "")
        case 3:
            monthString = NSLocalizedString("March", comment: "")
        case 4:
            monthString = NSLocalizedString("April", comment: "")
        case 5:
            monthString = NSLocalizedString("May", comment: "")
        case 6:
            monthString = NSLocalizedString("June", comment: "")
        case 7:
            monthString = NSLocalizedString("July", comment: "")
        case 8:
            monthString = NSLocalizedString("August", comment: "")
        case 9:
            monthString = NSLocalizedString("September", comment: "")
        case 10:
            monthString = NSLocalizedString("October", comment: "")
        case 11:
            monthString = NSLocalizedString("November", comment: "")
        case 12:
            monthString = NSLocalizedString("December", comment: "")
       
        default:
            monthString = ""
        }
        
        return monthString
    }
    
    private func getWeekendString(week:Int) -> String {
        var weekString:String!
        switch week {
        case 1:
            weekString = NSLocalizedString("Sun", comment: "Sunday")
        case 2:
            weekString = NSLocalizedString("Mon", comment: "Monday")
        case 3:
            weekString = NSLocalizedString("Tues", comment: "Tuesday")
        case 4:
            weekString = NSLocalizedString("Wed", comment: "Wednesday")
        case 5:
            weekString = NSLocalizedString("Thur", comment: "Thursday")
        case 6:
            weekString = NSLocalizedString("Fri", comment: "Friday")
        case 7:
            weekString = NSLocalizedString("Sat", comment: "Saturday")
        default:
            weekString = ""
        }
        return weekString
    }
    
    
}
