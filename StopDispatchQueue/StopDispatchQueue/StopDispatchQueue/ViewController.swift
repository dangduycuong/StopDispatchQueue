//
//  ViewController.swift
//  StopDispatchQueue
//
//  Created by Boss on 7/26/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var noteLabbel: UILabel!
    
    
    var timer = Timer()
    var data = BaseDataModel()
    
    var total = DataTotal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        noteTextView.delegate = self
        
    }
    
    @objc func timerAction() {
        noteLabbel.text = "Calling API..."
        

        let headers = [
            "x-rapidapi-host": "ip-geo-location.p.rapidapi.com",
            "x-rapidapi-key": "3eaa55e25cmshdb95e461cca8827p16799fjsn4425f9e011f3"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://ip-geo-location.p.rapidapi.com/ip/23.123.12.11?format=json")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                
                if let data = data {
                    do {
                        let db = try? JSONDecoder().decode(BaseDataModel.self, from: data)
                        print("data:\n", db as Any)
                    } catch {
                        fatalError()
                    }
                    
                }
            }
        })

        dataTask.resume()
        
//        getDataFromAPI(completion: { (data: BaseDataModel) in
//            self.data = data
//            print("Toạ độ: ", self.data.area?.code)
//        })
        //        let headers = [
        //            "x-rapidapi-host": "ip-geo-location.p.rapidapi.com",
        //            "x-rapidapi-key": "3eaa55e25cmshdb95e461cca8827p16799fjsn4425f9e011f3"
        //        ]
        //
        //        let request = NSMutableURLRequest(url: NSURL(string: "https://ip-geo-location.p.rapidapi.com/ip/23.123.12.11?format=json")! as URL,
        //                                                cachePolicy: .useProtocolCachePolicy,
        //                                            timeoutInterval: 10.0)
        //        request.httpMethod = "GET"
        //        request.allHTTPHeaderFields = headers
        //
        //        let session = URLSession.shared
        //        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        //            if (error != nil) {
        //                print(error)
        //            } else {
        //                print("fullURL: ", request)
        //                let httpResponse = response as? HTTPURLResponse
        //                if let data = try? JSONDecoder().decode(BaseDataModel.self, from: data!) {
        //                    self.data = data
        //                    print("httpResponse: ", data)
        //                }
        //
        //                print(httpResponse)
        //            }
        //        })
        //
        //        dataTask.resume()
    }
    
    func getDataFromAPI<T: Codable>(completion: @escaping(T)->()) {
        let headers = [
            "x-rapidapi-host": "ip-geo-location.p.rapidapi.com",
            "x-rapidapi-key": "3eaa55e25cmshdb95e461cca8827p16799fjsn4425f9e011f3"
        ]
        let url = URL(string: "https://ip-geo-location.p.rapidapi.com/ip/23.123.12.11?format=json")
        
        var urlRequest = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                print("fullURL: ", urlRequest)
                let httpResponse = response as? HTTPURLResponse
                
                
                print(httpResponse as Any)
                
                do {
                    let data = try JSONDecoder().decode(T.self, from: data!)
                    
                    DispatchQueue.main.async {
                        completion(data)
                        print("urlRequest: ", urlRequest)
                        
                    }
                } catch let error {
                    print("decode error: ", error)
                }
            }
        })
        
        dataTask.resume()
    }
    
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        noteLabbel.text = "Cancel Call API"
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}

