import Foundation

/*
 Creating a model that conforms to the api url: https://jsonplaceholder.typicode.com/photos

 example of an ImageURL: https://via.placeholder.com/600/92c952
 */

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}


