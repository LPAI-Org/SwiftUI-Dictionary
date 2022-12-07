import SwiftUI

struct Grids_Views: View {
    //MARK: Creating Columns for Grids
    let columns:[GridItem] = [
        
        ///GRID .Fixed which is a fixed size for each column
        
//        GridItem(.fixed(50), spacing: nil, alignment: nil),
//        GridItem(.fixed(75), spacing: nil, alignment: nil),
//        GridItem(.fixed(100), spacing: nil, alignment: nil),
//        GridItem(.fixed(75), spacing: nil, alignment: nil),
//        GridItem(.fixed(50), spacing: nil, alignment: nil)
        
      ///GRID Flexible (this is like flex box in CSS, auto resizes)
//
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil)
        
        ///GRID Adaptive layout takes a width and height but it adapts to the
//        GridItem(.adaptive(minimum: 10, maximum: 100), spacing: nil, alignment: nil),
//        GridItem(.adaptive(minimum: 150, maximum: 100), spacing: nil, alignment: nil)
        
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil)
        
    ]
    
    var body: some View {
        
        ScrollView {
            
            Rectangle()
                .fill(.orange)
                .frame(height: 400)
                .cornerRadius(9)
                .padding()
                
            //MARK: Advanced LazyVGrid Method
            //Adding LazyVGrid that come with the following parameters: columns, alignment, spacing, pinnedViews(this is very cool, it grabs the headers from Section views and pins them to the top), and content.
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 7,
                pinnedViews: [.sectionHeaders],
                content: {
                    Section(header: Text("Section 1")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.blue)
                        .cornerRadius(10)
                        .padding()
                            , content: {
                        ForEach(0..<50) { _ in
                            Rectangle()
                                .frame(height: 50)
                        }
                    })
                    Section(header: Text("Section 2")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.blue)
                        .cornerRadius(10)
                        .padding()
                            , content: {
                        ForEach(0..<50) { _ in
                            Rectangle()
                                .fill(.green)
                                .frame(height: 50)
                        }
                    })
               
                })
            
            //MARK: Standard LazyVGrid method
            //            LazyVGrid(columns: columns) {
            //                ForEach(0..<50) { _ in
            //                    Rectangle()
            //                        .frame(height: 50)
            //                }
            //            }
            
        }
    }
}

struct Grids_Previews: PreviewProvider {
    static var previews: some View {
        Grids_Views()
    }
}
