struct Event {
    var id: String
    let title: String
    let location: String
    let start: String
    let end: String
    let max_attendance: String
    let time_to_send_invites: String
    let list_close: String?
    let created_at: String
    let admin_invite_code: String
    let team_invite_code: String?
    let member_invite_code: String
    let event_role: String
    var event_users: [User]
}

