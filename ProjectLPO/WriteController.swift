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
    
  
    @IBOutlet weak var PickerView: UIPickerView!
    
    @IBAction func Write(_ sender: Any) {
    
        NSLog("start")
        
        
        let alertController = UIAlertController(
            title: "글쓰기",
            message: "글을 작성하시겠습니까?",
            preferredStyle: UIAlertControllerStyle.alert
        )
        
        let alertController2 = UIAlertController(
            title: "성공",
            message: "정상적으로 작성하였습니다",
            preferredStyle: UIAlertControllerStyle.alert
        )
        
        
        let okayAction2 = UIAlertAction(title: "OK", style: .default) { (action) in
        
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
            
            NSLog("취소했음")
        
        
        }
        
        let okayAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            
            
            
            Alamofire.request("http://feelfos.cafe24.com/politics/insertBoard.do",
                              method: .post,
                              parameters: ["userId":"FEELFOS222",
                                           "userNm":"트롤트롤오",
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
            
            
            NSLog("작성완료")
            
            alertController2.addAction(okayAction2)
            
            self.present(alertController2, animated: true , completion: nil)
            
            
        }
        
        alertController.addAction(okayAction)
        alertController.addAction(cancelAction)
        
        
        self.present(alertController, animated: true , completion: nil)
        
 
        
 
        

    
    }


    @IBAction func Cancle(_ sender: Any) {
        
     
         NSLog("\(self.WriteTitle.text!) <<< title .")
         NSLog("\(self.WriteBody.text!) <<< body .")
        
        
        self.WriteTitle.text = nil
        self.WriteBody.text = nil
    
        
        
    
    }
}

