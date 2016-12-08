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
    
//    func detailViewModelForRowAtIndexPath(_ indexPath: IndexPath) -> GuestDetailViewModel {
//        let location = (filteredGuests.isEmpty ? guests[indexPath.row] : filteredGuests[indexPath.row])
//        return GuestDetailViewModel(guest: guest)
//    }
    
//    func updateFiltering(_ searchText: String) -> Void {
//        filteredGuests = self.guests.filter { repo in
//            return repo.name.lowercased().contains(searchText.lowercased())
//        }
//    }
    
}
