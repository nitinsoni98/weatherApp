

import UIKit
import AVFoundation
import Alamofire
import ObjectMapper
import CoreData

class ViewController: UIViewController {
    
    var weather : WeatherResponse?
    var count:Int = 0
    var maximumTemperature :[Int] = []
    var minimumTemperature :[Int] = []
    var date : [String] = []
    @IBOutlet weak var CollectionViewMain: UICollectionView!



    override func viewDidLoad() {

        var avPlayer: AVPlayer!
        var avPlayerLayer: AVPlayerLayer!
        var paused: Bool = false
        super.viewDidLoad()

// API hit
        Alamofire.request("http://dataservice.accuweather.com/forecasts/v1/daily/5day/202350?apikey=Z7NpVINNJ8xBAGTtrPVSYZPnYAlAAXjJ").responseJSON { response in
            if let jsonData = response.result.value {
                self.weather = Mapper<WeatherResponse>().map(JSONObject: jsonData)!
                self.CollectionViewMain.reloadData()
                self.count = 5
                
                self.weather!.DailyForecasts?.enumerated().forEach{ index,data in
                self.maximumTemperature.append((data.Temperature!.Maximum!.Value)!)
                self.minimumTemperature.append((data.Temperature!.Minimum!.Value)!)
                self.date.append((data.Date)!)
                }
            }
        }
    
  // BackGround Player
       let url = Bundle.main.url(forResource: "storm_clouds_timelapse", withExtension: ".mp4")
        avPlayer = AVPlayer(url: url!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        avPlayer.play()
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = UIColor.clear;
        view.layer.insertSublayer(avPlayerLayer, at: 0)

        func playerItemDidReachEnd(notification: Notification) {
            avPlayer.seek(to: kCMTimeZero)
        }
        
// Coredata store
            let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity =  NSEntityDescription.entity(forEntityName: "ForecastCD",
                                                     in:managedContext)
            let headline = NSManagedObject(entity: entity!,
                                           insertInto: managedContext)
            headline.setValue(self.weather?.Headline?.Category! , forKey: "category")
 //           var hello = self.weather?.Headline?.Category!
            print("hello \(self.weather?.Headline?.Category)")
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
    }
}


// fetching Data
        func fetching(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ForecastCD")
        do {
            let results = try managedContext.fetch(fetchRequest)
            guard let category = results.value(forKey: "category") as? Float else{return "" }
                    print("\(category)")
        }
            catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            
            }
        
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let myWidth = self.view.frame.width
        let myHeight = self.view.frame.height
        return CGSize(width: myWidth, height:myHeight)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
            return count
    }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell1:CollectionViewCellMain = (collectionView.dequeueReusableCell(withReuseIdentifier:"identifierCollectionCellMain" , for: indexPath) as? CollectionViewCellMain) else{return UICollectionViewCell()}
            cell1.lblCategory.text = self.weather?.Headline?.Category!
            cell1.lblSeverity.text = "\(self.weather!.Headline!.Severity!)"
            cell1.lblCondition.text = self.weather!.Headline!.Category!
             
            cell1.maximum = maximumTemperature
            cell1.minimum = minimumTemperature
            cell1.date1 = date
            cell1.count1 = self.weather!.DailyForecasts!.count
           return cell1
        }
  }



