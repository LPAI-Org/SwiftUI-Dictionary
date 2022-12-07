import SwiftUI

struct Init_and_Enums: View {
    
    var colorSelection: Color
    let count:Int
    let title:String
    
    init(count: Int, fruit: Fruits) {
        self.count = count
        
        //MARK: Using Enums for conditional logic
        if fruit == .Apple {
            self.title = "Apples"
            self.colorSelection = .red
        }
        else {
            self.title = "Peaches"
            self.colorSelection = .orange
        }
        
    }
    //MARK: Creating Enums
    enum Fruits {
        case Apple, Peaches
    }
    
    var body: some View {
        VStack {
            Text("\(count)").underline().font(.title)
            Text("\(title)").font(.subheadline)
        }
        .font(.system(size: 30))
         .frame(width: 175, height: 175)
         .background(colorSelection)
         .cornerRadius(10)
         .foregroundColor(.white)
            
        
    }
}

struct Init_and_Enums_Previews: PreviewProvider {
    static var previews: some View {
        
        //MARK: Passing the data to the initializer to render the view
    
        HStack {
            Init_and_Enums(count: 3, fruit: .Peaches)
            Init_and_Enums(count: 9, fruit: .Apple)
        }
    }
}
