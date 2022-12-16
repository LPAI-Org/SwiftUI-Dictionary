import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancelable = Set<AnyCancellable>()
    ///PhotoModelCacheManager = using NSCache
  //  let manager = PhotoModelCacheManager.instance
    ///PhotoModelFileManager = using FileManager
    let manager = PhotoModelFileManager.instance
    
    let urlString: String
    let imageKey: String
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image")
        } else {
            downloadImage()
            print("Downloading image")
        }
    }
    
    func downloadImage() {
        print("Downloading Images now!")
        isLoading = true
        guard let url = URL(string: urlString)
        else {
            isLoading = false
            return
            
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
        //using map vs tryMap because we dont care to catch any errors here.
            .map { UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                
                guard let self = self, let image = returnedImage else { return }
                
                self.image = returnedImage
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancelable)

    }
    
}
