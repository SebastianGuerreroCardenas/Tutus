import Foundation

class AsssignmentListModel {
    var assignments = [Assignment]()
    //var filteredGuests = [Location]()
    
    let client = AssignmentClient()
    //let parser = RepositoriesParser()
    
    func refresh(_ completion: @escaping () -> Void) {
        client.fetchRepositories { assignments in
            self.assignments = assignments
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return assignments.count
    }
    
    func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < assignments.count else {
            return ""
        }
        return assignments[indexPath.row].location_id
        
    }
    
    func startForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < assignments.count else {
            return ""
        }
        return assignments[indexPath.row].start
    }
    func endForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < assignments.count else {
            return ""
        }
        return assignments[indexPath.row].end
    }
    
    func idForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < assignments.count else {
            return ""
        }
        return assignments[indexPath.row].id
    }
    
    func assignmentModelForRowAtIndexPath(_ indexPath: IndexPath) -> Assignment {
        return assignments[indexPath.row]
    }
    
//    func locationtDictionaryForRowAtIndexPath(_ indexPath: IndexPath) -> [String : String] {
//        let assignment: Assignment = assignment[indexPath.row]
//        return ["name": assignment.name, "description": assignment.description, "isEdit" : "true", "LocationId" : assignment.id]
//    }
    
}
