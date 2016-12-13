//
//  TutusTests.swift
//  TutusTests
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

//
// MODULES TO TEST:
// MessageClient - sendMessage
// QuestionClient - submitData, getQuestion
// AssignmentClient - getLocationsById, getRiskTeam, createAssignment, deleteLocation, deleteAssignment, getAssignments
// LocationClient - createLocation, deleteLocation, getLocations
// GuestClient - createGuest, checkGuestIntoEvent, deleteGuest
// EventClient - createEvent, createEventUser, getEventById, getUsersById, getEventUsers
// UserClient - createNewUser, getEventUsersByAuthToken, setMainUserRole
// LoginClient - fetchProfile, getData
//

import XCTest
@testable import Tutus
var currentEvent = ""
var newEvent = ""
var currentEventObject: Event!
var mainUser = UserClient()

class TutusTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        mainUser.dict["id"] = "tokenhere" as AnyObject?
        currentEventObject.id = 
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
