import Foundation

class AsssignmentListModel {
    var assignments = [AssignmentLocation]()
    //var filteredGuests = [Location]()
    
    let client = AssignmentClient()
    //let parser = RepositoriesParser()
    
    func refresh(_ completion: @escaping () -> Void) {
        client.getAssignments { assignments in
             
            for assigment in assignments {
                for loc in globalLocations {
                    if assigment.location_id == loc.id {
                        self.assignments.append(AssignmentLocation(id: assigment.id, location_name: loc.name, description: loc.description, start: assigment.start, end: assigment.end))
                    }
                }
            }
            
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
        return assignments[indexPath.row].location_name
        
    }
    
    func descriptionForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < assignments.count else {
            return ""
        }
        return assignments[indexPath.row].description
        
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
    
    func assignmentModelForRowAtIndexPath(_ indexPath: IndexPath) -> AssignmentLocation {
        return assignments[indexPath.row]
    }

    
}
