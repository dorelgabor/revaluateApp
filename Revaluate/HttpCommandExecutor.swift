//
//  HttpCommandExecutor.swift
//  Revaluate
//
//  Created by Dorel Gabor on 18/01/16.
//  Copyright © 2016 REVALUATE. All rights reserved.
//

import Foundation


class HttpCommandExecutor
{
    // This sets the current environment: Dev or Prod
    let setDevEnvironment = false
    
    private let prodURL = "https://revaluate-api-prod.herokuapp.com"
    private let devURL = "https://revaluate-api-dev.herokuapp.com"
    private var currentURL = ""
    
    init() {
        if (self.setDevEnvironment) {
            self.currentURL = devURL
        }
        else {
            self.currentURL = prodURL
        }
    }
    
    /**
     Executes a generic HTTP command.
     
     - Parameter pathURL The URL of the desired path.
     - Parameter params[String: AnyObject] A dictionary of items that will be converted to JSON format for the request.
     
     - Returns: NSDictionary The response given by the server in JSON format - to dictionary.
     */
    private func executeGenericCommand(pathURL: String, params: [String: AnyObject], completion: (result: NSDictionary?, error: NSError?)->())
    {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        let url = NSURL(string:self.prodURL + pathURL)
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        do {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
        } catch { }
        
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            if (error != nil) {
                print("Error submitting request: \(error)")
                completion(result: nil, error: error)
            }
            else {
                do {
                    let result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? NSDictionary
                    print(result)
                    completion(result: result, error: nil)
                    
                } catch { }
            }
        }
        task.resume()
    }
    
    /**
     Executes a Login command for a user.
     
     - Parameter email User's email address.
     - Parameter password User's password.
     
     - Returns: NSDictionary The response given by the server in JSON format - to dictionary.
     */
    func accountLogin(email: NSString, password: NSString, completion: (result: NSDictionary?, error: NSError?)->())
    {
        let pathURL = "/account/login"
        let params:[String: AnyObject] = [
            "email" : email,
            "password" : password ]
    
        self.executeGenericCommand(pathURL, params: params, completion: completion)
    }
}