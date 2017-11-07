//
//  ViewController.swift
//  webSrvcs
//
//  Created by Alejandro Gutierrez on 11/6/17.
//  Copyright © 2017 Alejandro Gutierrez. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKUIDelegate {

  
     var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let myUrl:URL = URL(string: "https://developer.apple.com")!
        let myRequest  = URLRequest(url: myUrl)
        //webView.load(myRequest)
        
        let task = URLSession.shared.dataTask(with: myRequest)
        {data,retreive,error in
            
            if error == nil
            {
                let dataString = NSString(data:data!,encoding:String.Encoding.utf8.rawValue)
                
                print(dataString!)
                
            }
            else
            {
                print(error!)
            }
            
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

