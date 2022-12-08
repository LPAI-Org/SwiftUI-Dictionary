import SwiftUI
import Combine

//MARK: Model
struct CodablePostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

//MARK: ViewModel
class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [CodablePostModel] = []
    var cancelable = Set<AnyCancellable>()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        //Combine metaphor logical approach
        /*
         //1. sign up for monthly subscription for package to be delivered
         //2. the company makes the package behind the scene
         //3. receive the package at your front door
         //4. check if the box was delivered accurately without any damages
         //5. now we check if the item is the item we ordered
         //6. Use the item!
         //7.. cancel at any time
         */
        
        //Applying the metaphor below with step by step explanation:
        /*
         //1. create the publisher
         URLSession.shared.dataTaskPublisher(for: url)
         //2. putting the publisher on the background thread
         ///note: - this is for demonstration purposes, as some do not automatically get thrown onto the background thread but URLSession.shared.dataTaskPublisher in our case does place the query on the background, and therefore it is not required to make a subscriber to place it on the background in this logic but if you had to, this is the way you would do it.
         //  .subscribe(on: DispatchQueue.global(qos: .background))
         //3. receive the data on the background to come on the main thread
         .receive(on: DispatchQueue.main)
         //4. try map -> Check if the data is good. We can do this tryMap in two ways: 1) creating a function and passing it into tryMap for shorter & cleaner code. 2) write the logic out within the tryMap.
         ///short hand version with function being passed into it:
         .tryMap(handleOutput)
         ///longer version with adding the logic within tryMap:
         //            .tryMap { (data, response) -> Data in
         //
         //                guard let response = response as? HTTPURLResponse,
         //                      response.statusCode >= 200 && response.statusCode < 300 else {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return data
         //            }
         //5. Decode the data into CodablePostModel
         .decode(type: [CodablePostModel].self, decoder: JSONDecoder())
         //6. use the data by using sink putting the item into our app, and we can use sink in two different ways. 1) handling the error with switch statement or 2) removing the error handling from Sink and applying a new modifier before it called .replaceError
       
         ///sink without handling error:
         
         .replaceError(with: []) // returning an empty array if there is an error
         .sink( receiveValue: { [weak self] returnedPosts in
                 self?.posts = returnedPosts
         }
         
         
         ///sink with handling error:
        
         .sink { completion in
         //you would not use a print statement like we did below on an actual app, this is used encase if the fetch failed from the API URL, to apply another logic here that would get executed encase it failed, how to handle the error for the user on the app.
         print("Sink: \(completion)")
         }
         // if all is well in API heaven, the receiveValue takes in the data that has successfully been obtained and passed into our @Published variable in our ViewModel at the top called 'posts'
            
         receiveValue: { [weak self] returnedPosts in
                  self?.posts = returnedPosts
         }
         
         //7. Store - cancel subscription if needed
         .store(in: &cancelable)
         */
        
        //MARK: Fetching Data
        ///The entire code steps above applied below:
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [CodablePostModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        //here we would handle the error .i.e. alert on screen
                        print("Error: \(error)")
                }
            } receiveValue: { PostArray in
                self.posts = PostArray
            }
            .store(in: &cancelable)
        
        
    }
    //MARK: Function
    //TryMap Function Logic Explained:
    /*
     TryMap Function. When we call the tryMap modifier, it provides us with the data that we can pass into it which is URLSession.DataTaskPublisher.Output. We copied it and created a function that passes this logic into a property of our choice which we called 'output' so that we can use the functions from URLSession.DataTaskPublisher.Output.
     
     In our case, URLSession.DataTaskPublisher.Output -> allowed our property 'output' to call the modifier .response
     */
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

//MARK: View
struct Download_with_Combine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) {
                post in
                VStack(alignment: .leading) {
                    
                    Text(post.title).font(.headline)
                    Text(post.body).foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct Download_with_Combine_Previews: PreviewProvider {
    static var previews: some View {
        Download_with_Combine()
    }
}
