//
//  ViewController.swift
//  LesDates
//
//  Created by Macinstosh on 08/01/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dateChoisie: UIDatePicker!
    
    // obtenir une string au format de votre choix
    @IBOutlet weak var dateStringLbl: UILabel!
    
    // obtenir un timeInterval
    @IBOutlet weak var timeIntervalLbl: UILabel!
    
    // Verif si aujourdhui,demain,hier,weekend
    @IBOutlet weak var calendarLbl: UILabel!
    
    // il y a + mois, heure, jour, etc
    @IBOutlet weak var ilyaLbl: UILabel!
    
    let format = "EEEE dd MMMM yy - HH:mm:ss - zzzz"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func dateChoisie(_ sender: UIDatePicker) {
        
        let date = sender.date
        print(date)
        print(format)
        
        // 1
        dateStringLbl.text = date.toString()
        dateStringLbl.text = date.stringWithFormat(format)
        
        //2 quand on va dans le passé c'est - le temps
        //  quand on va dans le futur c'est + le temps
        //  c'est un differentiel de temps
        timeIntervalLbl.text = "temps écoulé en secondes depuis maintenant: \(date.timeStamp())"
        calendarLbl.text = date.quelJour()
        ilyaLbl.text = date.components()
        
    }
    

}

extension Date {
    
    func toString() -> String {
        let formatteur = DateFormatter()
        formatteur.dateStyle = .long
        formatteur.timeStyle = .short
        formatteur.locale = Locale(identifier: "fr_FR")
        return formatteur.string(from:self)
    }
    
    func stringWithFormat(_ format: String) -> String {
        let formatteur = DateFormatter()
        formatteur.locale = Locale(identifier: "fr_FR")
        formatteur.dateFormat = format
        return formatteur.string(from:self)
    }
    
    func timeStamp() -> String {
        let tempsEcoule = self.timeIntervalSinceNow
        return String(format: "%.2f", tempsEcoule)
    }
    
    func quelJour() -> String {
        var str = ""
        let cal = Calendar.current
        if cal.isDateInToday(self) { str += "Aujourd'hui " }
        if cal.isDateInYesterday(self) { str += "Hier " }
        if cal.isDateInTomorrow(self)   { str += "demain "}
        if cal.isDateInWeekend(self) {str += "WeekEnd "}
        return str
    }
    
    func components() -> String {
        let cal = Calendar.current
        let components = cal.dateComponents([.month, .day, .hour, .minute], from: self, to: Date())
        let month = components.month ?? 0
        let day = components.day ?? 0
        let minute = components.minute ?? 0
        let hour = components.hour ?? 0
        return "temps écoulé -> mois: \(month), jour(s): \(day), heure(s): \(hour), minute(s): \(minute)"
    }
}

