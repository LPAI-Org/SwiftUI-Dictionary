import Foundation
import SwiftUI

/*
 
 Creating a calls to create our NSCache instance so that we follow the protocol of the NSCache variable we are creating below.
 
 This NSCache is setup to only accept a count of 200 images at a time and the max capacity is 200mb's based on the dimensions of the images times the number of countLimit we setup. If the cache increases from these thresholds, it automatically purges previous cached data.
 
 */

class PhotoModelCacheManager {
    
    static let instance = PhotoModelCacheManager()
    
    private init() {
        
    }
    
    var phohoCache: NSCache<NSString, UIImage> = {
       var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024  * 200 //might be 200mb
        return cache
    }()
    
    //we create an add function to take the NSCache variable above and append the setObject for the values that are coming in from the function, which is the 'key: String' and 'value: UIImage'
    
    func add(key: String, value: UIImage) {
        phohoCache.setObject(value, forKey: key as NSString)
    }
    
    //same principle as add function but instead we are getting the image from  the cache location using the keyname which would be /[somefilename].png
    func get(key: String) -> UIImage? {
        return phohoCache.object(forKey: key as NSString)
    }
}

