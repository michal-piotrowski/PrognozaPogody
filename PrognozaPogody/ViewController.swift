//
//  ViewController.swift
//  PrognozaPogody
//
//  Created by IHaveAMacNow on 10/10/2018.
//  Copyright © 2018 IHaveAMacNow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoContainer: UILabel!
    
    let WOEID_WARSAW: String = "523920"
    
    var Weathers: [DayWeather]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateStr = "2018/10/21"
        
        print("getting data from api on \(dateStr)")
        getWeatherInfoByDate(date: "2018/10/21")
        
        //Gather information from rest API for hardCoded localisation
        // Display those in a view inside the app
        // Do any additional setup after loading the view, typically from a nib.
    }

    /*
     * Date format is yyyy/mm/dd
     */
    func getWeatherInfoByDate(date: String)  -> DayWeather {
        return getWeatherInformation("https://www.metaweather.com/api/location/\(WOEID_WARSAW)/\(date)/", infoContainer)
    }
    
    func getWeatherInformation(_ url_str: String, _ label: UILabel) -> DayWeather {
        print("GET \(url_str)")
        let url: URL = URL(string: url_str)!
        let session = URLSession.shared
        var dayWeather = DayWeather()
        var infoString: String = ""
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error)
            in
            if data != nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                    // Assumption that latestForecast["min_temp"] returns NSNumber (actually, NSCFNumber)
                    let latestForecast = json[0]
                    if let minTemp = latestForecast["min_temp"] as? NSNumber {
                        infoString =  minTemp.stringValue + "is the minimal temperature on \(latestForecast["applicable_date"] as! String)"
                        dayWeather.min_temp = minTemp
//                        DispatchQueue.main.async {
//                            label.text = minTemp.stringValue
//                        }
                    }
                    print(infoString)
                }
                catch
                {
                    return
                }

                
            }
        })
        task.resume()
        return dayWeather
        
    }
}

