import Foundation

class EventGuestMemberListModel {
    var guests = [Guest]()
    var filteredGuests = [Guest]()
    
    let client = SearchMemberGuestListClient()
    
    func refresh(_ completion: @escaping () -> Void) {
        client.fetchRepositories { guests in
            self.guests = guests
            completion()
        }
    }
    
    func numberOfRows() -> Int {
        if filteredGuests.isEmpty {
            return guests.count
        } else {
            return filteredGuests.count
        }
    }
    
    func titleForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < guests.count else {
            return ""
        }
        if filteredGuests.isEmpty {
            return guests[indexPath.row].name
        } else {
            return filteredGuests[indexPath.row].name
        }
    }
    
    func birthdateForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < guests.count else {
            return ""
        }
        if filteredGuests.isEmpty {
            return guests[indexPath.row].birthdate
        } else {
            return filteredGuests[indexPath.row].birthdate
        }
    }
    
    func idForRowAtIndexPath(_ indexPath: IndexPath) -> String {
        guard indexPath.row >= 0 && indexPath.row < guests.count else {
            return ""
        }
        if filteredGuests.isEmpty {
            return guests[indexPath.row].id
        } else {
            return filteredGuests[indexPath.row].id
        }
    }
    
    func guestModelForRowAtIndexPath(_ indexPath: IndexPath) -> Guest {
        if filteredGuests.isEmpty {
            return guests[indexPath.row]
        } else {
            return filteredGuests[indexPath.row]
        }
    }
    
    func detailViewModelForRowAtIndexPath(_ indexPath: IndexPath) -> GuestDetailViewModel {
        let guest = (filteredGuests.isEmpty ? guests[indexPath.row] : filteredGuests[indexPath.row])
        return GuestDetailViewModel(guest: guest)
    }
    
    func updateFiltering(_ searchText: String) -> Void {
        filteredGuests = self.guests.filter { repo in
            return repo.name.lowercased().contains(searchText.lowercased())
        }
    }
    
}
