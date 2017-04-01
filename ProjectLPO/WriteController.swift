//
//  WriteController.swift
//  ProjectLPO
//
//  Created by Jihun Oh on 2017. 3. 29..
//  Copyright © 2017년 Jihun Oh. All rights reserved.
//

import UIKit
import Alamofire


class WriteController : UIViewController {
    
   
    @IBOutlet weak var WriteTitle: UITextField!
    @IBOutlet weak var WriteBody: UITextView!
    
    @IBAction func Write(_ sender: Any) {
    

        Alamofire.request("http://feelfos.cafe24.com/politics/insertBoard.do",
                          method: .post,
                          parameters: ["userID":"FEELFOS222",
                                       "userNM":"트롤트롤오",
                                       "boardCd":"001",
                                       "boardTitle":self.WriteTitle.text!,
                                       "boardActiveFg":"I",
                                       "boardBody1":self.WriteBody.text!,
                                       "boardBody2":" "
                                       ],
                          encoding: URLEncoding.default,
                          //encoding: URLEncoding.httpBody)
            //headers: ["Content-Type":"application/json", "Accept":"application/json"])
            headers: ["Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in if let JSON = response.result.value
            {
                NSLog("self.WriteTitle.text")

                print(JSON)
                }
        }
        
        

        
         NSLog("\(self.WriteBody.text) <<< good .")

        
        self.WriteTitle.text = nil
        self.WriteBody.text = nil

    
    }


    @IBAction func Cancle(_ sender: Any) {
        
     
         NSLog("\(self.WriteTitle.text!) <<< title .")
         NSLog("\(self.WriteBody.text!) <<< body .")
        
        
        self.WriteTitle.text = nil
        self.WriteBody.text = nil
    
        
        
    
    }
}

