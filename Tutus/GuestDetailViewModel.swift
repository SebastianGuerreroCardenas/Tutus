import Foundation

class GuestDetailViewModel {
    let guest: Guest
    
    init(guest: Guest) {
        self.guest = guest
    }
    
    func name() -> String {
        return guest.name
    }
//
//    func URLString() -> String? {
//        return repository.htmlURL
//    }
}
