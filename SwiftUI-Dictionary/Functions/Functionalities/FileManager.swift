import SwiftUI

//MARK: FILE MANAGER
class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_FolderName"
    //As soon as our app gets built, it creates a folder "MyApp_FolderName", unless if it already has one than its good to go. This is done so that the rest of our code below works since it will look for this folder name.
    init() {
        createFolderIfNeeded()
    }
    //Creating the folder
    func createFolderIfNeeded() {
        //first we created a property that takes in the path of the folder we want to create if it doesn't already exist then run the if bloc closure statement below
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path else {
            return
        }
        
        //if the file in the guard let path statement doesn't exist, then create the folder by calling the '.createDirectory' modifier and passing in the path name that we are getting from the 'guard let path' property above.
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try
                FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Successfully created a MyApp_FolderName folder path")
            } catch let error {
                print("Error creating folder: \(error)")
            }
        }
    }
    //Deleting folder
    func deleteFolder() {
        //deleting folder is similar to creating it. We first check for the file in the location of our folder. If yes, than run the 'do' block statement below
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path else {
            return
        }
        //Utilizing the FileManagers removeItem modifier to remove the file from the index of the path name we are passing from the 'guard let path' property we created above.
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Successfully deleting folder")
            
        } catch let error {
            print("Error deleting folder: \(error)")
        }
    }
    
    //Saving the Image
    func saveImage(image: UIImage, name: String) -> String {
        /*
         creating image property and giving UIImage, we can access the jpegData modifier to compress the image into data so we can store it and retrieve it when needed. This is the modifier because the image in our assets folder is .jpeg. If you had a png image, the modifier would be pngData or whatever type that may be.
         
         And the function takes also a name as a string, since the path name would be read as a string.
         */
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            return "Error saving file"
            
        }
        
        do {
            //here we take the compressed image above called 'data' and write it to the path name that we created as a string getPathForImage
            try data.write(to: path)
            print(path)
            return "Successfully saved "
            
            
        } catch let error {
            return "Error saving: \(error)"
        }
    }
    
    //Getting the image
    func getImage(name: String) -> UIImage? {
        //getPathForImage returns a URL< and the .path converts it to a string> which we need to pass into FileManager.default.fileExists
        guard let path = getPathForImage(name: name)?.path,
              //since the path names are read as a string, we had to convert the url into a string so we can read and grab it.
                FileManager.default.fileExists(atPath: path)
        else {
            print("Error getting file")
            return nil
        }
        //Here we are returning what we want specifically out of this function, UIImage. And passing in the contentsOf what we got back from 'guard let path' statement above.
        return UIImage(contentsOfFile: path)
    }
    //Deleting the image
    func deleteImage(name: String) -> String {
        
        guard
            //access the path through getPathForImage with the name its getting passed in to see if the image exist in the first place, if yes, than run the 'Do' function below, else it spits out the error message "Error getting file from path location"
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            return "Error getting file from path location"
            
        }
        //if the file exist, it tries to run the FileManagers '.remove' modifier from the path that it has found that got unwrapped above in our 'guard let path' statement.
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Successfully Deleted"
        }
        //for whatever reason you cant delete the file, we want to know why through the error statement below.
        catch let error {
            return "Error deleting the image: \(error)"
        }
    }
    
    //Function that goes into the directory we have told it to with the modifiers '.urls', '.appendingPathComponent', by stating go to cachesDirectory, then in folderName (MyApp_FolderName), append the name getting passed in (in our case its SJ) and the extension ".jpeg". It would result to ".../cachesDirectory/MyApp_FolderName/SJ.jpeg"
    func getPathForImage(name: String) -> URL? {
        guard let path =
        FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .appendingPathComponent("\(name).jpeg")
        else {
            print("Error getting path")
            return nil
        }
        return path
    }
}

//MARK: VIEW MODEL
class FileManagerViewModel: ObservableObject {
    //getting access to FileManager
    let manager = LocalFileManager()
    //The name of our image in our assets folder
    let imageName: String = "SJ"
    //Nick recommends using UIImage when working with image files in the background data so it is more widely acceptable and easier to use.
    @Published var image: UIImage? = nil
    //The messages that is getting displayed on the screen whenever we save or delete
    @Published var infoMessage: String = ""
    
    
    
    init() {
        //"getImageFromAssetsFolder" -> As it states, its getting it from the assets folder of the app itself
        getImageFromAssetsFolder()
        //"getImageFromFileManager" -> As it states, its getting it from the file manager where we have stored the data/image
        //  getImageFromFileManager()
    }
    
    //grabbing the image from our assets folder
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    //grabbing the image from our folder within the folder-manager directory that we created, in our case its /MyApp_FolderName/
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    //saving the image by calling LocalFileManager -> saveImage through the manager property that we created above.  This is passing the image into the folder
    func saveImage() {
        //using the guard let to unwrap image, otherwise you can't pass it into the manager.saveImage(image: +++) without unwrapping it.
        guard let image = image else { return }
        //saveImage basically takes the image, compresses it to a jpeg data and places it in the getPathForImage path
        infoMessage =  manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManager_Function: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
                if let image = vm.image{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(20)
                }
                
                HStack {
                    
                    Button(action: {
                        vm.saveImage()
                    }, label: {
                        Text("Save To FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.blue)
                            .cornerRadius(10)
                    })
                    
                    Button(action: {
                        vm.deleteImage()
                        
                    }, label: {
                        Text("Delete")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.red)
                            .cornerRadius(10)
                    })
                    
                }
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                Spacer()
                
                
                
            }
            .navigationTitle("File Manager")
            
            
        }
    }
}

struct FileManager_Previews: PreviewProvider {
    static var previews: some View {
        FileManager_Function()
    }
}
