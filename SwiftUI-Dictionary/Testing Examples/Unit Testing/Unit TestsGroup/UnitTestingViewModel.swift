import Foundation
import SwiftUI
import Combine


//MARK: View Model
class UnitTestingViewModel: ObservableObject {
    var cancelable = Set<AnyCancellable>()
    let dataService: NewDataServiceProtocol
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        
        guard !item.isEmpty else { return }
        
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = dataArray.first(where:{ $0 == item}) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where:{ $0 == item}) {
            print("Item saved: \(x)")
        }
        else {
            throw DataError.itemNotFound
        }
        
    }
    
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { returnItems in
            self.dataArray = returnItems
        }
    }
    
    func downloadWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                //
            } receiveValue: { [weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancelable)

    }
    
    enum DataError: LocalizedError {
        case noData, itemNotFound
    }
    
}
