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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateStr = "2018/10/21"
        
        print("getting data from api on \(dateStr)")
        getWeatherInformation("https://www.metaweather.com/api/location/\(WOEID_WARSAW)/\(dateStr)/", infoContainer)
        
        //Gather information from rest API for hardCoded localisation
        // Display those in a view inside the app
        // Do any additional setup after loading the view, typically from a nib.
    }

    func getWeatherInformation(_ url_str: String, _ label: UILabel) {
        print("GET \(url_str)")
        let url: URL = URL(string: url_str)!
        let session = URLSession.shared
        var infoString: String = ""
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error)
            in
            if data != nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                    
                    let latestForecast = json[0]
                    infoString = latestForecast["min_temp"] as! String + "is the minimal temperature on \(latestForecast["applicable_date"] as! String)"
                    
                    print(infoString)
                }
                catch
                {
                    return
                }

                
            }
        })
        task.resume()
        DispatchQueue.main.async {
            label.text = infoString
        }
    }
    
    

}

