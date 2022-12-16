/*
 What is being converted in this demo of download data+images from an API and looping over it on our screen.
 
 There are two ways to go about this method.
 
 1) We use NSCache - and we tweak what can be cached in terms of file size and total storage size to avoid crashing your app or someones device.
 
 Pros:
 
 -It doesn't need to be stored in the cloud
 -We have control over what type of data can be stored, size of the files, total overall storage capacity so it auto deletes older data as new ones come in.
 
 Cons:
- If the user closes the app, or reboots their phone, all the data is gone.
 
 2) FileManager is another method that we can store data on a users device. This is preferred if you need the user to have the data on the cloud, and device for future purpose use.
 
 Pros:
 -Available for future use until it is purposely deleted
 -Reduces the amount of memory it usage on the device
 
 Cons:
 -It wont delete on its own from the folder that we have created. We would need to invoke that somehow through a remove function on the app.
 
 
 2)
 
 The following will be used to apply this logic:
 
 -Codable
 -Background Threads
 -weak self
 -Combine
 -Publishers and Subscribers
 -FileManager
 -NSCache
 
 */



import SwiftUI

struct MainView_DownloadImage: View {
    /*
     Here we are observing the data we are getting from DownloadingImagesViewModel that is getting published in dataArray property in that class.
     */
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) {
                    model in
                    /*
                     Looping over the dataArray and then passing it into the HStack and image view that we created in our DownloadImagesRow so we can see the data on our view here in that format.
                     */
           DownloadingImagesRow(model: model)
                    
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

struct MainView_DownloadImage_Previews: PreviewProvider {
    static var previews: some View {
        MainView_DownloadImage()
    }
}
