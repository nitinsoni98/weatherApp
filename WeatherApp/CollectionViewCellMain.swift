//
//  CollectionViewCellMain.swift
//  WeatherApp
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class CollectionViewCellMain: UICollectionViewCell {

    var weather : WeatherResponse?
    var count1 : Int = 0
    var maximum : [Int] = [0]
    var minimum : [Int] = [0]
    var date1 : [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblEffectiveEpochDate: UILabel!
    @IBOutlet weak var lblSeverity: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblCondition: UILabel!




    override func awakeFromNib() {
        
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        

        
    }
    }


extension CollectionViewCellMain : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
     return count1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "identifierTableCell", for: indexPath) as? TableViewCell else{ return TableViewCell()}
        cell.lblMaximumTemperature.text = "\(maximum[indexPath.row])"
        cell.lblMinimumTemperature.text = "\(minimum[indexPath.row])"
        cell.lblDay.text = "\(getDayOfWeekString(today: date1[indexPath.row])!)"
        return cell
    }

        func getDayOfWeekString(today:String)->String? {
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
            if let todayDate = formatter.date(from: today) {
                let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
                let myComponents = myCalendar.components(.weekday, from: todayDate)
                let weekDay = myComponents.weekday
        switch (weekDay!) {
        case 1:
            return "monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        case 7:
            return "Sunday"
            
        default:
            return "Nil"
        }
    }
             return nil
    }
}
extension CollectionViewCellMain : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    guard let cell2:CollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier:"identifierCollectionCell" , for: indexPath) as? CollectionViewCell) else{return UICollectionViewCell()}
        
    return cell2
}
}
