import SwiftUI

class CacheManager {
    static let instance = CacheManager() // singleton
    //because we are making the init private, the singleton wont be called anywhere else but here.
    private init() {}
    
    /*The Reason we created a computed property of NSCache was to be able to customize what it should be limited to and therefore giving us control how much, what type, or limit on file size that should be cached. Adding the () brackets initiates this property*/
    //MARK: Cache storage
    var imageCache: NSCache<NSString, UIImage> = {
       let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 //100mb
        return cache
    }()
    
    //Adding to imageCache property that we created that consist of NSCache function. This allows us to use the modifier setObject, that takes in a key and Object, in our case its UIIamge Object and key that takes a string of name. We are returning a string so we can see if it has been applied on our view
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cache"
    }
    //Remove takes in the same principle as adding the image in the function above.
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from Cache"
    }
    
    //Function to get the image from cache
    func get(name: String) -> UIImage? {
        
        return imageCache.object(forKey: name as NSString)
    }
}


class CacheViewModel: ObservableObject {
    @Published var startingImage: UIImage? = nil
    @Published var cacheImage: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "SteveJobs"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
     startingImage = UIImage(named: imageName)
    }
    
    func saveToCache(){
        
        guard let image = startingImage else { return }
       infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
      infoMessage =  manager.remove(name: imageName)
    }
    
    func getFromCache() {
        
        if let returnedImage = manager.get(name: imageName) {
            cacheImage = returnedImage
            infoMessage = "Got image from Cache"
        }
        else {
            infoMessage = "Image not found in Cache"
        }
    }
}


struct NSCache_Function: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
       
                Text(vm.infoMessage).font(.headline)
                    .foregroundColor(.purple)
                    
                
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to Cache")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        vm.removeFromCache()
                        
                    }, label: {
                        Text("Delete from Cache")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    })
                    
                    
                    
                }
                
                if let image = vm.cacheImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
       
                
                Button(action: {
                    vm.getFromCache()
                    
                }, label: {
                    Text("Get from Cache")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .background(.green)
                        .cornerRadius(10)
                })
                Spacer()
                
            }.navigationTitle("Cache Example")
        }
        
        
    }
}

struct NSCache_Previews: PreviewProvider {
    static var previews: some View {
        NSCache_Function()
    }
}
