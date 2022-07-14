//
//  APICaller.swift
//  APIKit
//
//  Created by Ömer Faruk Kılıçaslan on 14.07.2022.
//

import Foundation




public class APICaller {
    
    public static let shared = APICaller()
    
    private init() {}
    
    public func fetchCourseNames(completion: @escaping ([String])-> Void) {
        
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            
            return
            
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else{
                completion([])
                return
                
            }
            
            //DECODE
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: String]] else {
                    completion([])
                    return
                    
                }
                    
                let names: [String] = json.compactMap({ $0["name"] })
                
                completion(names)
               
            } catch  {
                completion([])
            }
            
        }
        task.resume()
    }
    
}
