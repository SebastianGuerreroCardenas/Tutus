//
//  AssignmentViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 12/7/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class AssignmentViewController: BaseViewController {

    @IBAction func editAssignmentAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "AssignmentCreation", bundle: nil)
        let controller = loginStoryboard.instantiateViewController(withIdentifier: "AssignmentCreation") as UIViewController
        self.present(controller, animated: true, completion: nil)
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
