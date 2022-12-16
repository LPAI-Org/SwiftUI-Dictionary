import Foundation
import Combine

/*
 Here we created an ObservableObject class ViewModel that takes in the PhotoModel that we created and turns it into a Published variable that our app can subscribe to from anywhere.
 
 */
class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    /*
     PhotoModelDataService.instance is the file that is digesting the API data, and decoding the JSON data for us so we can use it easily in this ViewModel.
     */
    let dataService = PhotoModelDataService.instance
    var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    /*
     Here we are accessing the PhotoModelDataService.instance data that is getting stored in $photoModels empty Publisher array and passing that data into the Published variable of this class named 'dataArray' where we can subscribe to it somewhere else and deconstruct the data that is getting added to this array.
     
     Using .store to store the data and be able to cancel out of the data using AnyCancellable from Combine. We made it as a [weak self] so its not a strong reference to this subscriber and the data doesn't just save and get called upon every time we switch screens.
     */
    func addSubscribers() {
        /*
            photoModels is binding because we are getting data from PhotoModelDataService.photoModels and we are then passing into another publisher of this class through the sink method below.   */
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellable)
    }
}
