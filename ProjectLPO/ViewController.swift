//
//  ViewController.swift
//  ProjectLPO
//
//  Created by Jihun Oh on 2017. 3. 14..
//  Copyright © 2017년 Jihun Oh. All rights reserved.
//

import UIKit



class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    
    var page = 1
    
    lazy var list : [BoardVO] = {
        var datalist = [BoardVO]()
        return datalist
    }()
   
   /*
    
    var dataset = [
    
  
        ("FEELFOS","123123456","hoho","2017.03.10", "haha"),
        ("imosty","123123456","hoho","2017.03.10", "haha")
        
        
    ]
    
     var list : [BoardVO] {
        
        var datalist = [BoardVO]( )
        
        for (idx, rnum, hitcnt, crea_dtm,title) in self.dataset {
            
            let mvo = BoardVO( )
            
            mvo.title = title
            mvo.rnum = rnum
            mvo.hitcnt = hitcnt
            mvo.crea_dtm = crea_dtm
            mvo.idx = idx
            
            datalist.append(mvo)
            
        }
   
        return datalist
        
    }
 
 */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let idx = cell.viewWithTag(101) as? UILabel
        let rnum = cell.viewWithTag(102) as? UILabel
        let hit_cnt = cell.viewWithTag(103) as? UILabel
        let crea_dtm = cell.viewWithTag(104) as? UILabel
        let title = cell.viewWithTag(105) as? UILabel
        
        //cell.textLabel?.text = row.idx
        //cell.detailTextLabel?.text = row.crea_dtm
        
        //cell.textLabel?.text = idx
       //cell.textLabel?.text = row.title
        
        idx?.text       = row.idx
        rnum?.text      = row.rnum
        hit_cnt?.text   = "\(row.hit_cnt!)"
        crea_dtm?.text  = row.crea_dtm
        title?.text     = row.title
            
        
        NSLog("\(hit_cnt) <<< good .")

        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //NSLog("\(indexPath.row)번째 데이터가 클릭됨.")
        NSLog("\(indexPath.row)번째 데이터가 클릭됨.")
        
    }
   
   
    
    
    override func viewDidLoad() {
        
        let url = "http://feelfos.cafe24.com/sample/selectBoardList.do"
        
        let apiURI : URL! = URL(string: url)
        
        let apidata = try! Data(contentsOf: apiURI)
        
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        
        NSLog("API API Result = \(log)")
        
        
        do {
            
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            let list = apiDictionary["list"] as! NSArray
            
            for row in list {
                
                let r = row as! NSDictionary
                
                let mvo = BoardVO( )
                
                mvo.idx = r["IDX"] as? String
                mvo.rnum = r["RNUM"] as? String
                mvo.hit_cnt = ((r["HIT_CNT"] as! NSString).integerValue)
                mvo.crea_dtm = r["CREA_DTM"] as? String
                mvo.title = r["TITLE"] as? String
                
                self.list.append(mvo)
                
                NSLog("cut data = \(mvo.hit_cnt)")
                
                
            }
            
            
            
            
            
        }
         catch
         {
            
            
        }
        
        
        
        
    
        
        super.viewDidLoad()

        
        
                // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

