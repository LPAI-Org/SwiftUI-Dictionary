import Foundation
import SwiftUI

//MARK: Model
//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

//MARK: Custom Model
enum TabBarItem: Hashable {
    case home, favorites, profile, messages
    
    var iconName: String {
        switch self {
            case .home:
                return "house"
            case .favorites:
                return "heart"
            case .profile:
                return "person"
            case .messages:
                return "message"
        }
    }
    
    var title: String {
        switch self {
            case .home:
                return "home"
            case .favorites:
                return "Favorites"
            case .profile:
                return "Profile"
            case .messages:
                return "Messages"
        }
    }
    var color: Color {
        switch self {
            case .home:
                return .red
            case .favorites:
                return .blue
            case .profile:
                return .green
            case .messages:
                return .purple
        }
    }
}

