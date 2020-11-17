//
//  CalendarViewController.swift
//  Midterm
//
//  Created by Тогжан Салимова on 10/16/20.
//  Copyright © 2020 Тогжан Салимова. All rights reserved.
//
import FSCalendar
import UIKit

class CalendarViewController: UIViewController, FSCalendarDelegate {
    
    @IBOutlet weak var lbl: UILabel!
    
    var calendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.width)
        view.addSubview(calendar)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        lbl.text = "\(string)"
    }
}
