import SwiftUI

struct ScrollViewReader_Function: View {
    
    //MARK: PROPERTIES
    @State var textfiendNumber: String = ""
    @State var scrolltoIndex: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                
                TextField("enter number...", text: $textfiendNumber)
                    .frame(height: 55)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.purple, lineWidth: 5)
                            .frame(height: 55)
                    )
                    .keyboardType(.numberPad)
                
                
                Button(action: {
                    if let index = Int(textfiendNumber) {
                        scrolltoIndex = index
                    }
                }, label: {
                    
                    if scrolltoIndex > 50 {
                        Text("\(scrolltoIndex) does not exist")
                    } else {
                        Text("Jump to: \(scrolltoIndex)")
                            .padding().background(.blue).foregroundColor(.white).cornerRadius(10)
                    }
                })
                
                ScrollView {
                    //MARK: ScrollViewReader
                    ScrollViewReader {
                        proxy in
                        
                        ForEach(0..<51) {
                            index in
                            Text("This is item: \(index)")
                                .font(.headline)
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                                .padding()
                                .id(index)
                        }
                        .onChange(of: scrolltoIndex) { newValue in
                            withAnimation(.spring()) {
                                proxy.scrollTo(newValue, anchor: .top)
                            }
                        }
                    }
                    
                }
                .navigationTitle("ScrollView")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ScrollViewReader_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReader_Function()
    }
}
