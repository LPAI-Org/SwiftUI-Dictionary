import Foundation
import SwiftUI

class PhotoModelFileManager {
    static let instance = PhotoModelFileManager()
    
    let folderName = "downloaded_photos"
    
    private init() {
        createFolderIfNeeded()
    }
    //MARK: Creating folder
    /*
     Creating the folder if it doesn't exist already, where we would store the data that we are retrieving.
    */
    private func createFolderIfNeeded() {
        /*
         If the folder already exist, pass it into the url property. Else, return the following logic of 'if closure' that takes in the do/catch.
        */
        guard let pathName = getPhotoPath() else {
            return
        }
        /*
         if the folder doesn't exist in the pathName location we passed in, create the folder.
         */
        if !FileManager.default.fileExists(atPath: pathName.path) {
            /*
             Using FileManager.default.createDirectory function modifier that takes in the pathName property in our guard let statement above
             */
            do {
                try FileManager.default.createDirectory(at: pathName, withIntermediateDirectories: true)
                print("Created Folder!")
            } catch let error {
                print("Could not create folder! Error response: \(error)")
            }
        }
    }
    /*
     The path destination URL of where the folder is located.
    */
    private func getPhotoPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    /*
     This is checking for the folder /.../.../downloaded_photos
     
    If the image exist, return the file using the name of the file as 'key' plus adding the extension .png of what that file type is which will result to: /.../.../downloaded_photos/fileName.png
     */
    private func getImagePath(key: String) -> URL? {
        guard let folder = getPhotoPath() else {
            return nil
        }
        
        return folder.appendingPathComponent(key + ".png")
    }
    /*
     Adding the file if it doesn't exist: We know the API is returning png images, we will use the pngData() function modifier to convert the image to pngData that we can store in the location of our folder within the getImagePath that is taking in the 'key' as the name of the file. Else it will run the do/catch code block on creating the image within the getImagePath location using the .write function that comes with pngData.
    */
    func add(key: String, value: UIImage) {
        guard let data = value.pngData(),
              let url = getImagePath(key: key) else {
            return
        }
        do {
            try data.write(to: url)
        }
        catch let error {
            print("Error savings to file manager: \(error)")
        }
    }
/*
     Getting the image from our filePath location, if it doesn't find it, it returns nil. Otherwise, we append the UIImage from the url.path coming from the guard let url statement below.
*/
    func get(key: String) -> UIImage? {
        guard let url = getImagePath(key: key),
              FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
}
