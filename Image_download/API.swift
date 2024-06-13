//
//  API.swift
//  Image_download
//
//  Created by Macbook on 24/03/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage


enum MyPath: String {
    case random = "/photos/random"
    case search = "/search/photos"
    case latestImgs = "/photos"
}

enum ImageType: String {
    case raw = "raw"
    case full = "full"
    case regular = "regular"
    case small = "small"
    case thumb = "thumb"
}

class API {
    
    static var shared: API = API()

    func getRandomImages(image: @escaping (URL?)->()) {
        Req.shared.req(path: .random, method: .get) { data in
            image(URL(string: data?["urls"]["raw"].stringValue ?? ""))
        }
    }
    
    
    
    func getLatestImages(type: ImageType, page: Int = 1, perPage: Int = 15, images: @escaping ([URL]) -> Void) {
        
        let param = ["page" : page, "per_page" : perPage]
        
        Req.shared.req(path: .latestImgs, params: param, method: .get) { data in
            if let data = data {
                
                var imgs: [URL] = []
       
                for i in data.arrayValue {
                    if let validURL = URL(string: i["urls"][type.rawValue].stringValue) {
                        imgs.append(validURL)
                    }
                 
                }
                images(imgs)
            } else {
                images([])
            }
        }
    }
    
    
    
    func getLatestaSEARCH(type: ImageType, textName: String , page: Int = 1, perPage: Int = 15, images: @escaping ([URL]) -> Void) {
        
        let par: [String : Any] = ["page" : page, "per_page" : perPage , "query" : textName]
        
        Req.shared.req(path: .search, params: par,  method: .get) { dataa in
       
            if let dataa = dataa {
                
                var imagesss: [URL] = []
                
                for j in dataa["results"].arrayValue {
             
                    var validURLl = URL(string: j["urls"][type.rawValue].stringValue)
                 
                    imagesss.append(validURLl!)
                }
                
                images(imagesss)
                
            } else {
                images([])
            }
   
        }
    }

    
   
}
