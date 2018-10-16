//
//  ViewController.swift
//  PrognozaPogody
//
//  Created by IHaveAMacNow on 10/10/2018.
//  Copyright © 2018 IHaveAMacNow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateOfActiveWeather: UILabel!
    @IBOutlet weak var infoContainer: UILabel!
    
    let WOEID_WARSAW: String = "523920"
    
    var weathers: [DayWeather]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherInformation("https://www.metaweather.com/api/location/\(WOEID_WARSAW)/", infoContainer)
        self.setInitialView()
    }
    
    func getWeatherInformation(_ url_str: String, _ label: UILabel) {
        let url: URL = URL(string: url_str)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error)
            in
            if data != nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
//                    let latestForecast = json[0]
                    self.getWeatherFor5Days(json: json)
                }
                catch
                {
                    return
                }
            }
        })
        task.resume()
    }
    /**
     "id": 6722833333878784,
     "weather_state_name": "Light Cloud",
     "weather_state_abbr": "lc",
     "wind_direction_compass": "SE",
     "created": "2018-10-16T16:02:12.247823Z",
     "applicable_date": "2018-10-16",
     "min_temp": 6.1933333333333325,
     "max_temp": 19.176666666666666,
     "the_temp": 18.630000000000003,
     "wind_speed": 2.9387014361064714,
     "wind_direction": 140.3131693036207,
     "air_pressure": 1022.5450000000001,
     "humidity": 61,
     "visibility": 10.001901395848247,
     "predictability": 70
     */
    func getWeatherFor5Days (json: [String: Any]){
        for singleWeatherDict in json["consolidated_weather"] as! [[String: Any]] {
            let dayWeather = DayWeather()
            dayWeather.min_temp = (singleWeatherDict["min_temp"] as! NSNumber)
            dayWeather.max_temp = (singleWeatherDict["max_temp"] as! NSNumber)
            dayWeather.weather_state_name = (singleWeatherDict["weather_state_name"] as! String)
            dayWeather.weather_state_abbr = (singleWeatherDict["weather_state_abbr"] as! String)
            dayWeather.wind_speed = (singleWeatherDict["wind_speed"] as! NSNumber)
            dayWeather.wind_direction = (singleWeatherDict["wind_direction"] as! NSNumber)
            dayWeather.air_pressure = (singleWeatherDict["air_pressure"] as! NSNumber)
            dayWeather.applicable_date = (singleWeatherDict["applicable_date"] as! String)
            weathers.append(dayWeather)
        }
    }
    func setInitialView() {
        updateView(dayWeather: weathers[0])
    }
    
    func updateView(dayWeather: DayWeather) {
        DispatchQueue.main.async {
            
        }
    }
}

