//
//  Req.swift
//  Image_download
//
//  Created by Macbook on 24/03/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage



typealias MyResponse = (JSON?) -> Void

class Req {
    static var shared = Req()
    
    let base_url: String = "https://api.unsplash.com/"
    
    let generalHeader: HTTPHeaders = [
        "Accept-Version" : "v1",
        "Authorization" : "Client-ID CZgb1AWJNsRWIVAtC97H2JpwJxBzBDyc6Z-MRKKkC10"
    ]
    
    
    
    func req(path: MyPath, params: [String : Any]? = nil, method: HTTPMethod, responseJSON: @escaping MyResponse) {
        
        self.indicator(show: true)
        AF.request(self.base_url+path.rawValue, method: method, parameters: params,  headers: self.generalHeader).response { response in
            self.indicator(show: false)

            if let data = response.data {
                //SUCCESS REQUEST
                let json = JSON(data)
                if json["errors"].exists() {
                    print("🔴")
                    print(json["errors"].arrayValue)
                    responseJSON(nil)
                } else {
                    responseJSON(json)
                }
                
            } else {
                //RESPONSE ERROR
                responseJSON(nil)
            }
        }
    }
    
    
    
    
    
    private func indicator(show: Bool) {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.tag = 9998
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            if show {
                window.addSubview(indicator)
                indicator.center = window.center
                indicator.startAnimating()
            } else {
                if let indi = window.viewWithTag(9998) {
                    indi.removeFromSuperview()
                }
            }
        }
        
        
        
    }
}
