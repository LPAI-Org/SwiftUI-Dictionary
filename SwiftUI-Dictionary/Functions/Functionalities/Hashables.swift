import SwiftUI

//MARK: Hashable 
struct MyCustomModel: Hashable {
    let title: String
    let subtitle: String
    
    //Unsure why this function below is needed, since it works the same with or without.
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(title + subtitle)
//    }
}

struct Hashable_Function: View {
    
    let data: [MyCustomModel] =
    [MyCustomModel(title: "One", subtitle: "First"),
     MyCustomModel(title: "Two", subtitle: "Second"),
     MyCustomModel(title: "Three", subtitle: "Third"),
     MyCustomModel(title: "Four", subtitle: "Fourth"),
     MyCustomModel(title: "Five", subtitle: "Fifth")]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40){
                ForEach(data, id: \.self) {
                    item in
                    Text(item.title.hashValue.description)
                        .font(.headline)
                    Text(item.subtitle.hashValue.description)
                        .font(.caption)
                }
            }
            
        }
    }
}

struct Hashable_Previews: PreviewProvider {
    static var previews: some View {
        Hashable_Function()
    }
}
