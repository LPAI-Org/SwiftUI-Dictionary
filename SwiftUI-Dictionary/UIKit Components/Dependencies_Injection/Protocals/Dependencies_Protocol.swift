import Foundation
import SwiftUI
import Combine


//MARK: PROTOCOL
//any class or struct that takes in this protocol will need to conform to getData()
protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostModel], Error>
}

