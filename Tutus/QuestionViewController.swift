//
//  QuestionViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 12/8/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class QuestionViewController: BaseViewController {

    @IBOutlet weak var questionLabel: UILabel!
    var questionClient = QuestionClient()
    @IBOutlet weak var responseField: UITextField!
    
    var question: Question!
    
    @IBAction func Submit(_ sender: Any) {
        questionClient.submitData(questionId: question.id, response: responseField.text! as String) {
            self.openViewControllerBasedOnRole(animationStyle: "fade")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuestion()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        getQuestion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getQuestion() {
        questionClient.getQuestion() { question in
            self.question = question
            self.questionLabel.text = question.question
        }
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
