import SwiftUI

/*
 case empty
 No image is loaded.
 
 case success(Image)
 An image successfully loaded.
 
 case failure(Error)
 An image failed to load with an error.

 */

struct AsyncImage_Styles: View {
    
    let url = URL(string: "https://picsum.photos/200/")
    
    var body: some View {
       
        VStack {
            Spacer()
            Text("Regular Async Image")
            //MARK: Async Image - Version 1
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
        }
            
            Spacer()
            Spacer()
            Text("Async Image + Phase w/Switch Statement")
            //MARK: Async Image - Version 2
            AsyncImage(url: url) { phase in
                switch phase {
                    case .empty:
                            ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                    case .failure:
                      Image(systemName: "questionmark").font(.headline)
                    default:
                        Image(systemName: "questionmark").font(.headline)
                }
            }
            
            Spacer()
            
            
            
        }
        

    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage_Styles()
    }
}
