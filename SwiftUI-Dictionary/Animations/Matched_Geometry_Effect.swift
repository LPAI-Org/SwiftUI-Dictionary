import SwiftUI
//MARK: Match Geometry Effect
struct Matched_Geometry_Effect: View {
    
    @State private var isClicked: Bool = false
    
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            //Creating two shapes and basically use a boolean to bring the shape on or off the screen.
            //If false, show the circle.
            if !isClicked {
                Circle()
                    //matchedGeometryEffect modifier taking in an ID that needs to match to all other shapes that you want to animate on or off. That is how the system connects each one which stores it in the namespace state where it checks from.
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
                
                
            }
            Spacer()
            //othewise, show the RoundedRectangle. 
            if isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
              
                
            }
         
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onTapGesture {
            withAnimation(.easeInOut) {isClicked.toggle()
                
            }
        }
    }
}

struct Matched_Geometry_Effect_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectExample2()
    }
}

//MARK: Second real world example
///Best use case on how to use match geometry effect. Best used on platonic shapes.
struct MatchedGeometryEffectExample2: View {
    
    let categories: [String] = ["Home", "Popular", "Saved"]
    
    @Namespace private var namespace2
    
    @State private var selected: String = ""
    
    var body: some View{
        HStack{
            ForEach(categories, id: \.self) {
            item in
                ZStack(alignment: .bottom) {
                    
                    if selected == item {
                        
                        RoundedRectangle(cornerRadius: 10).fill(Color.red)
                            .matchedGeometryEffect(id: "Category-Background", in: namespace2)
                            .frame(width: 35, height: 2)
                            .offset(y: 10)
                    }
                    Text(item)
                        .foregroundColor(selected == item ? .red: .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = item
                    }
                }
            }
        }
        .padding()
    }
}
