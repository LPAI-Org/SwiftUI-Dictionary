import SwiftUI

struct State_Wrapper: View {
    //MARK: State variables
    @State var backgroundColor: Color = .green
    @State var myTitle:String = "My Title"
    @State var count: Int = 0
    
    var body: some View {
        
        //Few examples below showing how we can change the state of a background, title and even keep count.
        ZStack {
            backgroundColor.ignoresSafeArea()
            VStack(spacing: 20) {
                
                Text("\(myTitle)")
                Text("Count: \(count)")
                
                
                HStack(spacing: 20) {
                    Button("Button 1") {
                        backgroundColor = .red
                        myTitle = "Red Was Pressed"
                        count += 1
                    }
                    Button("Button 2") {
                        backgroundColor = .blue
                        myTitle = "Blue Was Pressed"
                        count -= 1
                    }
                }
                
            }.foregroundColor(.white)
        }
    }
}

struct State_Previews: PreviewProvider {
    static var previews: some View {
        State_Wrapper()
    }
}
