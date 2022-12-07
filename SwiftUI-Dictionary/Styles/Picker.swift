import SwiftUI

struct Picker_Styles: View {
    
    @State var selected: String = "1"
    @State var filteredOptions = [
        "Most Recent", "Most Popular", "Most Liked"
    ]
    
    //MARK: Segmented Appearance
    
    //The init below will change the color of all segmented pickers within a struct. Keep that in mind, but it allows us to change the color of the picker within a segmented style
    init() {
        //Color of the section box
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.blue
        
        //Below we have created a Text attribute to change by creating a property that takes in a UIKit format called [NSAttributedString.Key : Any]. Its a dictionary that takes a parameter and a key which can be color, or anything else. In our case, we picked the foregroundColor to be white (Colors needs to be in UIKit format)
        let attribute: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.white
        ]
        
        UISegmentedControl.appearance().setTitleTextAttributes(attribute, for: .selected)
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Age")
                Text(selected)
            }
            //MARK: Picker 1
            Picker(selection: $selected) {
                ForEach(0..<8) {
                    Text("\($0)")
                    //Always need a tag if you want to have the data update from your binding variable, otherwise it wont update.
                        .tag("\($0)")
                }          } label: {
                    Text("Picker")
                }
            //The pickerstyle allow us to change the different style of pickers
                .pickerStyle(.segmented)
                .background(.orange)
                .padding(.bottom, 50)
            
            
            //MARK: Picker 2
            Menu {
                Picker(selection: $selected, label: EmptyView()) {
                    ForEach(filteredOptions, id: \.self) { options in
                        HStack {
                            Text("\(options)")
                            Image(systemName: "heart.fill")
                        }.tag(options)
                        
                    }
                }
            } label: {
                customLabel
            }
        }
        
    }
    var customLabel: some View {
        HStack {
            Image(systemName: "paperplane")
            Text(String(selected))
            Spacer()
            Text("⌵")
                .offset(y: -4)
        }
        .foregroundColor(.white)
        .font(.title)
        .padding()
        .frame(height: 32)
        .background(Color.blue)
        .cornerRadius(16)
    }
}


struct Picker_Previews: PreviewProvider {
    static var previews: some View {
        Picker_Styles()
    }
}
