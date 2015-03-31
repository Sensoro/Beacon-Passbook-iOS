//
//  ViewController.swift
//  BeaconPassbook-Swift
//
//  Created by David Yang on 15/3/30.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController, PKAddPassesViewControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPassbook(sender: AnyObject) {
        if let passPath = NSBundle.mainBundle().URLForResource("Generic", withExtension: "pkpass"){
            var error : NSError?;
            let passData : NSData! = NSData(contentsOfURL: passPath)
            let pkPass = PKPass(data : passData, error: &error);
            
            let pkLibrary = PKPassLibrary();
            
            if pkLibrary.containsPass(pkPass) {
                UIApplication.sharedApplication().openURL(pkPass.passURL);
            }else{
                let vc = PKAddPassesViewController(pass: pkPass);
                
                vc.delegate = self;
                presentViewController(vc, animated: true, completion: nil);
            }
        }
    }

    @IBAction func saveToAlbum(sender: AnyObject) {
        
        UIImageWriteToSavedPhotosAlbum(image.image,
            self,"image:didFinishSavingWithError:contextInfo:",nil);
        
    }
    
    //MARK: PKAddPassesViewControllerDelegate
    func addPassesViewControllerDidFinish(controller: PKAddPassesViewController!) {
        controller.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func image(image : UIImage, didFinishSavingWithError error : NSError!, contextInfo info: UnsafePointer<Void>) {
        if error == nil {
            let alert = UIAlertView(title: "提示", message: "保存成功", delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }else{
            let alert = UIAlertView(title: "提示", message: "保存失败", delegate: nil, cancelButtonTitle: "OK");
            alert.show();
        }
    }
}

