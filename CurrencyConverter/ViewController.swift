//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ashish Sharma on 12/24/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var AEDLabel: UILabel!
    @IBOutlet weak var AENLabel: UILabel!
    @IBOutlet weak var ALLLabel: UILabel!
    @IBOutlet weak var AMDLabel: UILabel!
    @IBOutlet weak var ANGLabel: UILabel!
    @IBOutlet weak var AOALabel: UILabel!
    
//    var jsonData : [String : Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    // CURRENCIES IN RESPECT TO EURO
    
    
    
    func getDataFromUrl() {
        var semaphore = DispatchSemaphore (value: 0)
        
        let url = "https://api.apilayer.com/fixer/latest?"
        var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("llgoG86nargf9TQquHMtr8elb7FuXBml", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
                
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                
                // ASYNC
                DispatchQueue.main.async {
                    print("JSON Response from JSONSerialization")
                    print(jsonResponse)
                    print("**************************")
                    
                    if let rates = jsonResponse["rates"] as? [String : Any] {
                        if let aed = rates["AED"] as? Double {
                            self.AEDLabel.text = "AED: \(aed)"
                        }
                        if let afn = rates["AFN"] as? Double {
                            self.AENLabel.text = "AFN: \(afn)"
                        }
                        if let all = rates["ALL"] as? Double {
                            self.ALLLabel.text = "ALL: \(all)"
                        }
                        if let amd = rates["AMD"] as? Double {
                            self.AMDLabel.text = "AMD: \(amd)"
                        }
                        if let ang = rates["ANG"] as? Double {
                            self.ANGLabel.text = "ANG: \(ang)"
                        }
                        if let aoa = rates["AOA"] as? Double {
                            self.AOALabel.text = "AOA: \(aoa)"
                        }
                        
                    }

                    
                    
                    
                }
                
                
            } catch {
                
            }
            
            
            
            
            
//            let gotRates = try JSONDecoder().decoder.decode(CurrencyData, from: data)
//            print(gotRates.rates)
            // From Documentation *************************
//            struct GroceryProduct: Codable {
//                var name: String
//                var points: Int
//                var description: String?
//            }
//
//            let json = """
//            {
//                "name": "Durian",
//                "points": 600,
//                "description": "A fruit with a distinctive scent."
//            }
//            """.data(using: .utf8)!
//
//            let decoder = JSONDecoder()
//            let product = try decoder.decode(GroceryProduct.self, from: json)
//
//            print(product.name) // Prints "Durian"
            
            print(String(data: data, encoding: .utf8)!) // This does not serialize but only prints the JSON object. This is not useful.
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }

    
    
    @IBAction func getRatesButtonPressed(_ sender: UIButton) {
        
        getDataFromUrl()
        
    }
}

