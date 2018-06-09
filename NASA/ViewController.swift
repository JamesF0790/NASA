//
//  ViewController.swift
//  NASA
//
//  Created by James Frost on 6/6/18.
//  Copyright © 2018 James Frost. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchPhotoInfo { (fetchedInfo) in
            print (fetchedInfo)
        }
    }

    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void){
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            ]
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data){
                completion(photoInfo)
            } else {
                print ("IT GO WRONG")
                completion(nil)
            }
        }
        task.resume()
    }
}

