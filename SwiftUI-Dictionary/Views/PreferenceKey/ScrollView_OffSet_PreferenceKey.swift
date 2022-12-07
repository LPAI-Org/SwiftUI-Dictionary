import SwiftUI

//MARK: Creating PreferenceKey
struct ScrollViewOffSetPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGFloat = 0
    ///here we are taking the CGFloat Value that is coming in and outputting it into nextValue property as a Function which is why it has ()->
    static func reduce(value: inout Value, nextValue: () -> Value) {
        //FYI - This nextValue you can customize if you want within this closure.
        value = nextValue()
    }
    
    
}


extension View {
    func onScrollViewOffSetChanged(action: @escaping (_ offset: CGFloat) -> Void) -> some View{
        self.background(GeometryReader(content: { GeometryProxy in
            Text("")
                .preference(key: ScrollViewOffSetPreferenceKey.self, value: GeometryProxy.frame(in: .global).minY)
        }))
        .onPreferenceChange(ScrollViewOffSetPreferenceKey.self) { value in
                action(value)
        }
    }
}

struct ScrollView_OffSet_PreferenceKey: View {
    
    
    let title: String = "New Title Here!!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
            titleLayer
                   .opacity(Double(scrollViewOffset) / 63.0)
                   .onScrollViewOffSetChanged { offset in
                       self.scrollViewOffset = offset
                   }
               
            contentLayer

            }.padding()
           
        
                }
        .overlay {
            Text("\(scrollViewOffset)")
        }
    
        .overlay(alignment: .top) {
     
                navBarLayer.opacity(scrollViewOffset < 40 ? 1.0:0)
        }
    }
}
extension ScrollView_OffSet_PreferenceKey {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<100) {
            _ in
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }

    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.blue)
    }
    
}

struct ScrollView_OffSet_PreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
            ScrollView_OffSet_PreferenceKey()
    }
}
