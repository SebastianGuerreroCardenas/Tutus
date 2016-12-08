//
//  MessageViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 12/8/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    var messageClient = MessageClient()
    @IBOutlet weak var messageField: UITextField!
    
    @IBAction func sendMessage(_ sender: Any) {
        messageClient.sendMessage(message: messageField.text! as String ) {
            print("sent message")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
