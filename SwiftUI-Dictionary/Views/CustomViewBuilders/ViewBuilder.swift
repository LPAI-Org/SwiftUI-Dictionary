import SwiftUI

struct HeaderViewRegular: View {
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title).font(.largeTitle)
                    .fontWeight(.semibold)
                if let iconName = iconName {
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }
            }
            if let description = description {
                Text(description).font(.callout)
            }
  
        RoundedRectangle(cornerRadius: 5)
            .frame(height: 2)
            
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
    }
}
//MARK: Generic View
struct HeaderViewGeneric<Content: View>: View {
    let title: String
        //MARK: Property passing in Content
    ///Obtaining Generic from  Content from <Content: View> to be passed into the property
    let content: Content
    
    //MARK: Creating ViewBuilder Function
    ///Below you can see that we are passing in @ViewBuilder as an argument that this init() would accept as a function. Making it more versatile to use with different view or views.
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title).font(.largeTitle)
                    .fontWeight(.semibold)
            }
                
            content
            
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 2)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding()
    }
}

struct CustomHStack<Content:View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
        content
        }
    }
}


struct ViewBuilder_Views: View {
    
    @State private var textFieldText = String()
    
    var body: some View {
        ScrollView {
            VStack {
//                HeaderViewRegular(title: "Coffee", description: "Holy Moly Cream", iconName: nil)
//
//                HeaderViewRegular(title: "New Coffee", description: nil, iconName: nil)
//
//                HeaderViewRegular(title: "Icon Version", description: nil, iconName: "person.fill")
//
//                HeaderViewRegular(title: "Icon Version 2", description: "Love Saves Us All", iconName: "heart.fill")
                
                Divider()
                //MARK: GenericView Initializer Versions
                ///content is now our generic view property that we can pass any type of view into it. Demonstrating two different views within 'content'
//                HeaderViewGeneric(title: "HeaderView Generic Image", content: Image(systemName: "house"))
//
//                HeaderViewGeneric(title: "TextField Generic", content: TextField("Enter some text here...", text: $textFieldText))
//
//                HeaderViewGeneric(title: "Triple Generic View", content: VStack {
//                    HStack {
//                        Text("Output: ")
//                        Text(textFieldText)
//                    }
//
//                    TextField("", text: $textFieldText)
//
//                })
                
                //MARK: GenericView Passing in several Views into Content
                ///this version is taking the init() that you have created in HeaderViewGeneric
                HeaderViewGeneric(title: "Generic with function") {
                    VStack {
                        HStack{
                            Text(textFieldText)
                            Image(systemName: "person")
                        }
                        TextField("Enter something...", text: $textFieldText)
                        
                    }
                }
                
                //MARK: Custom HSTACK Generic
                
                CustomHStack {
                    VStack{
                        Text("WORD!")
                        Text("BIG")
                    }
                            Text("BIRD!")
                            Image(systemName: "bird")
                }
                
                Divider()
                
                ///Custom HSTACK
                CustomHStack {
                    Text("Hi")
                    Text("Hi!!!")
                    Image(systemName: "heart.fill").foregroundColor(.red)
                }
                
                //Regular HSTACK
                
                HStack{
                    Text("Hi")
                    Text("Hi!!!")
                }
                
                
            Spacer()
            }
        }
    }
}


//MARK: VIEW-BUILDER REAL WORLD EXAMPLE
struct LocalViewBuilder: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        VStack {
            
            headerView
        }
    }
    
    
    ///Below we have created a viewbuilder property that will return us a view which does not require the condition that is passed into property to be wrapped in a view like a H/V/Stack. Adding @ViewBuilder, it will conform to any view.
  @ViewBuilder  private var headerView: some View {
///Switch statement is recommended in a case like this
      switch type {
          case .one:
              viewOne
          case .two:
              viewTwo
          case .three:
              viewThree
      }
      ///but you can also do it as an if-else statement which would work like a switch statement.
//        if type == .one {
//            viewOne
//        } else if type == .two {
//            VStack {
//            viewTwo
//            }
//        }
//        else if type == .three {
//            viewThree
//        }
    }
    
    private var viewOne: some View {
        Text("Tiffany")
    }
    
    private var viewTwo: some View {
        Text("Adrian")
    }
    
    private var viewThree: some View {
        Text("Sarah & Marcus")
    }
}




struct ViewBuilder_Previews: PreviewProvider {
    static var previews: some View {
        LocalViewBuilder(type: .three)
    }
}


