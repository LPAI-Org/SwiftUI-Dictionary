import Foundation
import Combine
import SwiftUI



//MARK: PROTOCOL
protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (_ item: [String]) -> ())
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

//MARK: MOCK DATA
class NewMockDataService: NewDataServiceProtocol {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
        "One", "Two", "Three"
        ]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ item: [String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            completion(self.items)
        })
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        //eraseToAnyPublisher to get it to any publisher
        Just(items).eraseToAnyPublisher()
        //tryMap to run
            .tryMap { publishedItems in
                //publishedItems is not empty otherwise, throw a badServerResponse
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                //otherwise return publishedItems
                return publishedItems
            }
        //eraseToAnyPublisher again in order to get it to any publisher
            .eraseToAnyPublisher()
    }
    
}

