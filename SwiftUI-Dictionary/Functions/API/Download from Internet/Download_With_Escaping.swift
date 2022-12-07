import SwiftUI

struct PostModelCodable: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingViewModel: ObservableObject{
    
    @Published var posts: [PostModelCodable] = []
    
    init(){
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
    
    //MARK: First approach to decode JSON data without using a function
//        URLSession.shared.dataTask(with: url) { data, response, error in
//
//            //guard let statement below encompasses all the four guard let statements in the context below into one line.
//            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Error Downloading data")
//                return
//            }
            
            //Below the data + error + response + response code implemented separately in their own guard let statement
            
//            guard let data = data else {
//                print("No data")
//                return
//            }
            
//            guard error == nil else {
//                print("Error: \(String(describing: error))")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else {
//                print("Invalid response")
//                return
//            }
//
//            guard response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Status code should be 2xx, but it is: \(response.statusCode)")
//                return
//            }
            
//            print("Successfully downloaded data!")
//            print(data)
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString ?? "No data")
//
//
//            guard let newPost = try? JSONDecoder().decode([PostModelCodable].self, from: data) else { return }
//
//            DispatchQueue.main.async { [weak self] in
//                self?.posts.append(contentsOf: newPost)
//            }
//
//
//        }
//        //.resume() starts the function. Like a start button
//        .resume()
        
        //MARK: Second approach to decode Using function to decode JSON data (most efficient)
        //here we are taking the function that was created below and we are now using the JSON decoder to decode the response (if the response is between 200-300) and converting with our PostModelCodable. Using DispatchQueue to force a [weak self] so that if you move between screens it doesnt keep re-rendering the same API call.
        downloadData(fromURL: url) { returnedData in
            if let data = returnedData {
                guard let newPost = try? JSONDecoder().decode([PostModelCodable].self, from: data) else { return }
                
                //taking the data from the background thread and parsing it to our main thread to append to the screen.
                ///note: this would work with or without DispatchQueue.main.async but it would throw the following error at us: "Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates."
                DispatchQueue.main.async { [weak self] in
                    ///you can use the .append(contentsOf: ) method or simply pass in the newPost data into posts publish variable above.
                    ///one approach
                    //self?.posts.append(contentsOf: newPost)
                    ///second approach
                    self?.posts = newPost
                }
            } else {
                print("No Data Returned")
            }
        }
        
    }
    //Using escaping closure to create an async function that accepts the data (if there is any) and checks the response. If the response is between 200-300, it returns the data into our handler and outputs it for decoding.
    //MARK: Function for second approach
    ///this function allows us now to use this on any URL of our choice for any API call, without having to rewrite the entire block of code within the 'first approach'
    func downloadData(fromURL url: URL, handler: @escaping (_ returnedData: Data?) -> ()){
        //We copied the URLSession code block from the first approach
        ///URLSession.shared.dataTask automatically goes into a background thread
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //guard let statement below encompasses all the four guard let statements in the context below into one line.
            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error Downloading data")
                handler(nil)
                return
            }
            
            handler(data)
        }
        //.resume() starts the function. Like a start button
        .resume()
    }
}


struct Download_With_Escaping: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        NavigationView{
            List {
                ForEach(vm.posts) {
                    posts in
                    LazyVStack(alignment: .leading) {
                        Text(posts.title).font(.headline).textCase(.uppercase).padding(.bottom, 20)
                        Text(posts.body).font(.body)
                        
                    }
                    .frame( maxWidth: .infinity)
                    .padding(.bottom)
                }
            }.navigationTitle("Codable")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Download_With_Escaping_Previews: PreviewProvider {
    static var previews: some View {
        Download_With_Escaping()
    }
}
