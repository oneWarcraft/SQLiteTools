//
//  ViewController.swift
//  test
//
//  Created by 王继伟 on 16/7/17.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://t.cn/RtvCrTg")
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse?, data :NSData?, error:NSError?) in
            
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

