//
//  User.swift
//  Revaluate
//
//  Created by Dorel Gabor on 19/01/16.
//  Copyright © 2016 REVALUATE. All rights reserved.
//

import Foundation

class User {
    
    func loginUser(email: NSString, password: NSString, completion: (result: NSDictionary?, error: NSError?)->()) {
        let httpCommandExecutor = HttpCommandExecutor()
        
        httpCommandExecutor.accountLogin(email, password: password, completion: completion)
    }
}