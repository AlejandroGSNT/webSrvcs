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

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textField: UITextField!
    var word:String?
    /*URL:
     https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=json
     */
    /*URL:
     
     https://es.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=sega
     
     */
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        view = webView
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func search(_ sender: Any)
    {
        word = textField.text!
        
        let apiUrl = "https://es.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=\(word!)"
        let encodedUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let urlObject = URL(string: encodedUrl!)
        
        let task = URLSession.shared.dataTask(with: urlObject!)
        {
            (data,response,error) in
            if error != nil
            {
                print(error!)
            }
            else
            {
                do
                {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    as! [String:Any]
                    
                    let querySubJson = json["query"] as! [String:Any]
                    
                    //let pageId = querySubJson.keys
                   // let pageIdString = pageId.first!
                    let queryPages = querySubJson["pages"] as! [String:Any]
                    let pageIdString = queryPages.keys.first!
                    print(queryPages)
                    let queryId = queryPages[pageIdString] as! [String:Any]
                    let queryExtract = queryId["extract"] as! String
                    
                    DispatchQueue.main.sync {
                        self.webView.loadHTMLString(queryExtract, baseURL: nil)
                    }
                    
                }
                catch
                {
                    print("El procesamiento del JSON tuvo un errorcillo")
                }
                
                
                    
            }
        }
        task.resume()
        //begins alert
        let alertNotFound = UIAlertController(title: "No encontrado", message: "lo siento, pero wikipedia no tiene lo que usted está buscando", preferredStyle: .alert)
        alertNotFound.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alertNotFound, animated: true, completion: nil)
        //ends
    }



}

