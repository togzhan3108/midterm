

import Foundation

class UsersResponse {
    var users : [Data]?
    var page : Int?
    var perPage : Int?
    var total : Int?
    var totalPages : Int?
}

struct Data : Decodable {
    let avatar : String
    let email : String
    let firstName : String
    let id : Int
    let lastName : String
}
