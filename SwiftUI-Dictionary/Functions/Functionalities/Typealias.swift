import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}
//MARK: typealias
///creating a new name of an existing type but need the same model structure
typealias TvModel = MovieModel

struct Type_alias_Function: View {
    
    @State var item: TvModel = TvModel(title: "SuperMan", director: "Mark", count: 5)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("Number: \(item.count)")
        }
    }
}

struct Typealias_Previews: PreviewProvider {
    static var previews: some View {
        Type_alias_Function()
    }
}
