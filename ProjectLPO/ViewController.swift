//
//  ViewController.swift
//  ProjectLPO
//
//  Created by Jihun Oh on 2017. 3. 14..
//  Copyright © 2017년 Jihun Oh. All rights reserved.
//



import UIKit
import Alamofire


class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    
   
    
    var page = 1
    
    lazy var list : [BoardVO] = {
        var datalist = [BoardVO]()
        return datalist
    }()

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func Refresh(_ sender: Any) {
        
                self.list.removeAll()
        
       NSLog("CLICK !!!!! ")

       self.viewDidLoad()
        
       self.viewWillAppear(true)
        
        
       /// tableView.reloadData()
        //self.view.layoutIfNeeded()
        
      // self.viewIfLoaded
        
       // self.loadView() // 이 부분을 수행하면...
        
       self.tableView.reloadData()
        
        
    }
    
    
   
   
    
   
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
        NSLog("555")
        
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       NSLog("666")
        
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let idx = cell.viewWithTag(101) as? UILabel
        let rnum = cell.viewWithTag(102) as? UILabel
        let hit_cnt = cell.viewWithTag(103) as? UILabel
        let crea_dtm = cell.viewWithTag(104) as? UILabel
        let title = cell.viewWithTag(105) as? UILabel
        let boardBestCnt = cell.viewWithTag(106) as? UILabel
        let reply = cell.viewWithTag(107) as? UILabel
        
        //cell.textLabel?.text = row.idx
        //cell.detailTextLabel?.text = row.crea_dtm
        
        //cell.textLabel?.text = idx
       //cell.textLabel?.text = row.title
        
        idx?.text       = row.idx
        rnum?.text      = row.rnum
        hit_cnt?.text   = "\(row.hit_cnt!)"
        crea_dtm?.text  = row.crea_dtm
        title?.text     = row.title
        boardBestCnt?.text = "\(row.boardBestCnt!)"
        reply?.text = "\(row.reply!)"
        
            
        
        NSLog("\(hit_cnt) <<< good .")

        NSLog("777")
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //NSLog("\(indexPath.row)∫번째 데이터가 클릭됨.")
        NSLog("\(indexPath.row)번째 데이터가 클릭됨.")
        
    }
    
    
    
    override func viewDidLoad() {
        
        let token_check = UserDefaults.standard.string(forKey: "token")!
        
        NSLog("Local temp 1 = \(token_check)")
        
        if ( token_check == nil )
        {
            //UserDefaults.standard.set("feelfos_token", forKey: "token")
            //UserDefaults.standard.synchronize()
            
            
            NSLog("token check nil = \(token_check)")
            
            
            
        }
        else
        {
            
            
            //self.tabBarController?.selectedIndex = 3
            //self.tabBarController?.selectedViewController?.viewDidAppear(true)
          
            
            
            //[self.tabBarController.selectedViewController viewDidAppear:YES];
            
            NSLog("token check OK  = \(token_check)")
        
        }
        
      //  UserDefaults.standard.set("123123213" , forKey: "temp")
      //  UserDefaults.standard.synchronize()
        
      //  let value = UserDefaults.standard.string(forKey: "temp")
        
        
      //  NSLog("Local temp 2 = \(value)")
      //  NSLog("Local temp 2 = \(value2)")
        
        
        
        NSLog("111")
        
        let url = "http://feelfos.cafe24.com/politics/searchPoliticsBoardInfo.do"
        
        let apiURI : URL! = URL(string: url)
        let apidata = try! Data(contentsOf: apiURI)
        
        
        
        
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        //let log2 = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        
        NSLog("API API Result = \(log)")
        //NSLog("API API Result2 = \(log2)")
        
         do {
            NSLog("222")
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            let list = apiDictionary["PoliticsList"] as! NSArray
            
            for row in list {
                
                let r = row as! NSDictionary
                
                let mvo = BoardVO( )
                
                mvo.idx = r["userNm"] as? String
                mvo.rnum = r["boardBody1"] as? String
                mvo.hit_cnt = ((r["boardSearchCnt"] as! NSString).integerValue)
                mvo.crea_dtm = r["regDt"] as? String
                mvo.title = r["boardTitle"] as? String
                mvo.reply = ((r["replyCnt"] as! NSString).integerValue)
                mvo.boardBestCnt = ((r["boardBestCnt"] as! NSString).integerValue)
                                
                self.list.append(mvo)
                
                //NSLog("cut data = \(mvo.hit_cnt)")
                
                
            }
            
            

            
            
            
        }
        
        catch
         {
            
            
        }
    
        
        NSLog("333")
        
        super.viewDidLoad()
        NSLog("444")
        
        
        // Do any additional setup after loading the view, typically from a nib.

        
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

