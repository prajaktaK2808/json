//
//  ViewController.swift
//  swiftJsonParsing
//
//  Created by Felix ITs 08 on 23/12/19.
//  Copyright © 2019 FelixITS. All rights reserved.
//

import UIKit
//https://api.github.com/repositories/19438/commits
class ViewController: UIViewController {
    
    enum JsonErrors:String,Error {
        case responseError = "Response Error"
        case dataError = "Data error"
        case conversionError = "Conversion Error"
    }
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJson()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func parseJson()
    {
        let str = "https://api.github.com/repositories/19438/commits"
        let url = URL(string: str)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            do
            {
                guard let response = response else
                {
                    throw JsonErrors.responseError
                }
                guard let data = data else
                {
                    throw JsonErrors.dataError
                }
                guard  let array =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)  as? [[String:Any]]
                else
                {
                   throw JsonErrors.conversionError
                
                }
                for item in array
                {
                    
                    let commitDic = item["commit"] as? [String:Any]
                    let authorDic = commitDic?["author"] as? [String:Any]
                    let nameStr = authorDic?["name"] as? String
                    print(nameStr!)
                    
                }
                
                
                
            }
            catch let error
            {
                print(error.localizedDescription)
            }
            
            
        }
        dataTask.resume()
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

