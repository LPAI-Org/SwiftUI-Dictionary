import Foundation
import Combine
/*
 This class is used to download the images/data. We are creating its own class with its own functions so it can be used widely across our entire app through any view we desire. If this was in our ViewModel, it would only be accessible if you observe that ViewModel in its entirety when we only want to get the functionality of downloading images, we would be better off separating that part of the code and making its own file to be reused across our app.
 */

class PhotoModelDataService {
    static let instance = PhotoModelDataService() // singleton
    /*
     Making a private init, makes our singleton inaccessible for other places of our app to create another instance of this class
    */
    var cancellable = Set<AnyCancellable>()
    @Published var photoModels: [PhotoModel] = []

   
    private init() {
        downloadData()
    }
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
        /*once we have the data from tryMap, we need to decode the json.
        */
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
        /*
         Then we need to store the data that we decoded.
         */
            .sink { completion in
                /*
                this is a similar method as a Do/Catch method, but this is particularly checking if the data coming in is good or bad.
                */
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("error downloading data: \(error)")
                }
            }
                /*
                 if the data has been passed through the decoder properly and its finished, we take the value that is received and we append the data to the @Publish property photoModels
                */
                receiveValue: { [weak self] returnedPhotoModel in
                guard let self = self else { return }
                self.photoModels = returnedPhotoModel
            }
        /*
            store cancellable to terminate the connection upon completion, so it stops running in the background of our app.
        */
            .store(in: &cancellable)
    }
    /*
     Creating a private func to use within our TryMap for the URLSession.shared.dataTaskPublisher. Its checking if the URL has responded with some data by checking the URL status code if its within 200-300, its good to go. Otherwise, drop the connection with no Data.
     
     The parameter within this function was obtained when we tried to add the modifier .tryMap to our downloadData logic, it outputted that we need to pass a code block that conforms to:
 ---> "Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>.Output" <----
     So we took from the above 'URLSession.DataTaskPublisher' and '.Output' within our function that would result in the same if we passed in the same code block within the tryMap.
     
     */
    private func handleOutput(_ output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        //output the data that is coming in
        return output.data
    }
}
