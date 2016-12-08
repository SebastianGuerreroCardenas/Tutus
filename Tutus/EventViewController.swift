//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "eventUsersCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "eventUserCell")
        addSlideMenuButton()
        currentEvent = newEvent
        setLabels()
        scrollView.contentSize.height = 1000
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentEventObject.event_users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventUserCell", for: indexPath) as! eventUsersCell
        cell.nameLabel?.text = currentEventObject.event_users[indexPath.row].full_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

