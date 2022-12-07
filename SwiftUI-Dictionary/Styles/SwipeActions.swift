import SwiftUI

struct SwipeActions_Styles: View {
    @State var fruits:[String] = ["apple", "orange","banana", "peach"]
    var body: some View {
        List {
            
            ForEach(fruits, id: \.self ) {
                Text($0.capitalized)
                //MARK: SWIPE ACTION 1 - Trailing
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Archive", action: {}).tint(.blue)
                        Button("Save", action: {}).tint(.green)
                        Button("Junk", action: {}).tint(.red)
                    }
                //MARK: SWIPE ACTION 2 - Leading
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button("Reply", action: {}).tint(.green)
                        Button("Reply All", action: {}).tint(.orange)
                        Button("Forward", action: {}).tint(.red)
                    }
                    //Note: allowsFullSwipe set to = true will allow the user to fully swipe to the left or right and cause an auto action to occur. *best practice is to use it when its only one button for an action*
                
            }
        }
    }
}

struct SwipeActions_Previews: PreviewProvider {
    static var previews: some View {
        SwipeActions_Styles()
    }
}
