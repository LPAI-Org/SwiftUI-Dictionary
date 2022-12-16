
import SwiftUI

/*

 This is extracting the HStack that would have been in our main view so the code is minimal in our main view. There is no API or subscriber on this view. What you see is the dummy data added to the preview below so we can have a visual of how it would look once the API parse the data through this view using the Model -> PhotoModel. Basically conforming to the data that our api is providing us. 
 
 */

struct DownloadingImagesRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack{
            DownloadingImageView(url: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading ) {
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundColor(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct DownloadingImagesRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesRow(model: PhotoModel(albumId: 1, id: 1, title: "Title", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/600/92c952"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
