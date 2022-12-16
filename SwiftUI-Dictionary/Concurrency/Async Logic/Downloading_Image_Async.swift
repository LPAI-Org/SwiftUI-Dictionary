//MARK: Topic - Async Await
/*
 Doing it in two methods.
 
 1) Combine
 2) Async Await
 
 This will allow us to see what is the differences and the similarities
 */

import SwiftUI
import Combine

class DownloadImageAsyncImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    //Handling the data
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
        
    }
    
    //Three ways of approaching asynchronous methods (1.Escaping, 2. Combine, 3. Async)
    
    //MARK: Downloading using @Escaping
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()){
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }.resume()
    }
    
    //MARK: Downloading using Combine
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({$0})
            .eraseToAnyPublisher()
    }
    
    //MARK: Downloading using Async await
    //cleaner & preferred - just need to add async throws to any function
    func downloadWithAsync() async throws -> UIImage? {
        do {
            //Grabbing the URL in our properties above, and passing the data/response into two properties
            let (data, response) = try await URLSession.shared.data(from: url)
            //using our custom function handleResponse, we are now passing in the data & response created in the let constant
            let image = handleResponse(data: data, response: response)
            return image
        } catch {
            throw error
        }
    }
}

//MARK: VIEW MODEL
class DownloadingImagesWithAsyncAwait: ObservableObject {
    @Published var image: UIImage? = nil
    let loader = DownloadImageAsyncImageLoader()
    var cancellable = Set<AnyCancellable>()
    
    func fetchImage() async {
        //MARK: 3 Different Fetching methods
        //Using Escaping:
        /*
         loader.downloadWithEscaping { [weak self] image, error in
         DispatchQueue.main.async {
         self?.image = image
         }
         }
         */
        //Using Combine:
        /*
         loader.downloadWithCombine()
         .receive(on: DispatchQueue.main)
         .sink { _ in
         //
         } receiveValue: { [weak self] image in
         self?.image = image
         }
         .store(in: &cancellable)
         
         */
        //Using Async:
        if let image = try? await loader.downloadWithAsync() {
           await MainActor.run {
                self.image = image
            }
        }
    }
}


struct Downloading_Image_Async: View {
    
    @StateObject private var viewModel = DownloadingImagesWithAsyncAwait()
    
    var body: some View {
        
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }.onAppear {
            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

struct Downloading_Image_Async_Previews: PreviewProvider {
    static var previews: some View {
        Downloading_Image_Async()
    }
}
