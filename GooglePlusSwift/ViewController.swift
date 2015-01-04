//
//  ViewController.swift
//  GooglePlusSwift
//
//  Created by Fernando Olivares on 10/15/14.
//  Copyright (c) 2014 Spiffy. All rights reserved.
//

import UIKit

//G+
import AddressBook
import MediaPlayer
import AssetsLibrary
import CoreLocation
import CoreMotion

class ViewController: UIViewController, GPPSignInDelegate {
    
    var email = ""
    
    @IBAction func switchClicked(sender: UISwitch) {
        
            println("switch has been clicked")
            
            let request = NSMutableURLRequest(URL: NSURL(string: "http://nileswest.herokuapp.com/change_status")!)
            request.HTTPMethod = "POST"
            var status = 2
            if sender.on{
                status = 1
            }

            let postString = "email="+email+"&secret_key=DEVISING&status="+String(status)
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil {
                    println("error=\(error)")
                    return
                }
                
                println("response = \(response)")
                
                let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("responseString = \(responseString)")
            }
            task.resume()
            
            
            
       
    }
    
    var signIn : GPPSignIn?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var alert = UIAlertController(title: "Hey", message: "This is  one Alert", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Working!!", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        signIn = GPPSignIn.sharedInstance()
        signIn?.shouldFetchGoogleUserEmail = true
        signIn?.shouldFetchGooglePlusUser = true
        signIn?.clientID = "492971078631-jc36td2n8vds9tcscacuso3gvd0kg7l7.apps.googleusercontent.com"
        signIn?.scopes = [
            kGTLAuthScopePlusMe,
            kGTLAuthScopePlusUserinfoEmail]
        signIn?.delegate = self
        signIn?.authenticate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: G+
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        println("======")
        println(auth.userEmail)
        email = auth.userEmail
        println("======")
    }
    
    func didDisconnectWithError(error: NSError!) {
        println(error.localizedDescription)
        
    }
}

