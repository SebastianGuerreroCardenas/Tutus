import Foundation

class LocationListModel {
    var locations = [Location]()
    //var filteredGuests = [Location]()
    
    let client = LocationClient()
    //let parser = RepositoriesParser()
    
    func refresh(_ completion: @escaping () -> Void) {
        client.fetchRepositories { locations in
            self.locations = locations
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        return locations.count
    }
    
    func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < locations.count else {
            return ""
        }
        return locations[indexPath.row].name

    }
    
    func descriptionForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < locations.count else {
            return ""
        }
        return locations[indexPath.row].description
    }
    
    func idForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < locations.count else {
            return ""
        }
        return locations[indexPath.row].id
    }
    
    func locationtModelForRowAtIndexPath(_ indexPath: IndexPath) -> Location {
        return locations[indexPath.row]
    }
    
    func locationtDictionaryForRowAtIndexPath(_ indexPath: IndexPath) -> [String : String] {
        let location: Location = locations[indexPath.row]
        return ["name": location.name, "description": location.description, "isEdit" : "true", "LocationId" : location.id]
    }
    
}
