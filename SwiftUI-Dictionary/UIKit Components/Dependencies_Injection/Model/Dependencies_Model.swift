import Foundation
import SwiftUI

//MARK: MODEL
struct PostModel: Identifiable, Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
