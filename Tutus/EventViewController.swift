//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var maxAttendaceLabel: UILabel!
    @IBOutlet weak var inviteStartLabel: UILabel!
    @IBOutlet weak var inviteEndLabel: UILabel!
    @IBOutlet weak var adminCodeLabel: UILabel!
    @IBOutlet weak var memberCodeLabel: UILabel!
    @IBOutlet weak var teamCodeLabel: UILabel!

    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSlideMenuButton()
        currentEvent = newEvent
        setLabels()
        scrollView.contentSize.height = 1000
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabels() {
        eventNameLabel.text = currentEventObject.title
        locationLabel.text = currentEventObject.location
        startTimeLabel.text = currentEventObject.start
        endTimeLabel.text = currentEventObject.end
        maxAttendaceLabel.text = currentEventObject.max_attendance
        inviteStartLabel.text = currentEventObject.time_to_send_invites
        inviteEndLabel.text = currentEventObject.list_close
        adminCodeLabel.text = currentEventObject.admin_invite_code
        memberCodeLabel.text = currentEventObject.member_invite_code
        teamCodeLabel.text = currentEventObject.team_invite_code
    }
    
}

