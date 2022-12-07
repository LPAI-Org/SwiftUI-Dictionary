import Foundation
import SwiftUI
import Combine


//MARK: VIEW-MODEL
class DependencyInjectionModel: ObservableObject {
    
    @Published var dataArray: [PostModel] = []
    var cancelable = Set<AnyCancellable>()
    var dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
   private func loadPosts() {
       dataService.getData()
           .sink { _ in
               //Weak self implies not to hold on to the data and to keep it on the view that it is being called on and it wont leak into any child view.
           } receiveValue: { [weak self] returnPosts in
               self?.dataArray = returnPosts
           }
       //Store (not grocery store, but rather like 'Storing data' in a past tense) is a type-erasing cancellable instance in the specified set. The set in which to store this AnyCancellable.
           .store(in: &cancelable)
       /*
        func sink(
            receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void),
            receiveValue: @escaping ((Self.Output) -> Void)
        ) -> AnyCancellable
        */
       //sink returns AnyCancellable as per the above. So if our code doesn't have a return for AnyCancellable, it will throw an error. When the AnyCancellable is destroyed, it cancels the subscription. In our example, if we did not store the AnyCancellable and passed it into store() as we have done, sink would  be destroyed immediately, therefore cancelling the subscription immediately. Instead, we want it to cancel once we have obtained the data.
       
 
           

    }
}


//MARK: PRODUCTION DATA SERVICE
class ProductionDataService: DataServiceProtocol {
    
//    static let instance = ProductionDataService() //This is called a 'Singleton', not recommended.

    //The code below is a better logic, whereas you can inject any url that conforms to the same model (PostModel), without having to write another Fetch request
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostModel], Error>{
        URLSession.shared.dataTaskPublisher(for: url)
            //map takes all the data coming in from the array and passing it into our variable $0
        /* UUSING THE MAP WITHOUT .DATA WILL THROW -> Cannot convert value of type 'URLSession.DataTaskPublisher.Output' (aka '(data: Data, response: URLResponse)') to closure result type 'JSONDecoder.Input' (aka 'Data')*/
        //Therefore our map requires us to add '.data' to obtain the data being passed into it from our PostModel.
            .map({$0.data})
        //Here we are decoding the JSON
            .decode(type: [PostModel].self, decoder: JSONDecoder())
        //.receive: Specifies the scheduler on which to receive elements from the publisher
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

//MARK: MOCK DATA SERVICE
//creating a fake testing class so we can do tests without effecting the production. This is the best method to approach your app to test it.
class MockDataServices: DataServiceProtocol {
    
    let testData: [PostModel]
    
    //Initializing some fake data to load if there is no fake data being passed into it. This is optional.
    init(data: [PostModel]?) {
        self.testData = data ??
        [
            PostModel(userId: 1, id: 1, title: "One", body: "One"),
            PostModel(userId: 2, id: 2, title: "Two", body: "Two")
        ]
    }
    
    func getData() -> AnyPublisher<[PostModel], Error> {
       //Just is a Publisher that emits an output to an subscriber just once and then finishes
        Just(testData).tryMap({ $0 }).eraseToAnyPublisher()
        //  public func tryMap<T>(_ transform: (Output) throws -> T) -> Result<T, Error>.Publisher
        //eraseToAnyPublisher wraps this publisher with a type eraser
            
    }
}

