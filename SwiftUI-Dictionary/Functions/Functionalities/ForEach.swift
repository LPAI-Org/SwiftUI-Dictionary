import SwiftUI

struct ForEach_Function: View {
    
    let names: [String] = ["Tiffany", "Adrian", "Sarah", "Mark"]
    
    let count: Int = 101
    
    var body: some View {
        
        //Looping over a forEach in two different manners
        
        VStack {
            ScrollView {
                //First way
                ForEach(names.indices, id: \.self) { value in
                    Text("\(names[value]): \(value)")
                }
                
                //Second Way
                ForEach(0..<101) {
                    Text("\($0)")
                }
                
            }
        }
    }
}

struct ForEach_Previews: PreviewProvider {
    static var previews: some View {
        ForEach_Function()
    }
}
