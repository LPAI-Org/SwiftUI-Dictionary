import SwiftUI

struct onTabGesture_Functions: View {
    
    @State var isSelected:Bool = false
    
    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 25)
                .frame(height: 200)
                .foregroundColor(isSelected ? .green:.red)
            
            //MARK: Button Version
            //Buttons have an indicator to show the user it was tapped
            Button {
                isSelected.toggle()
            } label: {
                Text("Button")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(25)
            }
            
            //MARK: Text + onTabGesture Version
            //This does not show the user a response that the button was tapped
            Text("TabGesture")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(25)
                .onTapGesture {
                    isSelected.toggle()
                }
            //MARK: onTabGesture + count Version
            Text("TabGesture Double-Tap")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(25)
                .onTapGesture(count: 2) {
                    isSelected.toggle()
                }
            
            Spacer()
        }.padding(40)
    }
}

struct onTabGesture_Previews: PreviewProvider {
    static var previews: some View {
        onTabGesture_Functions()
    }
}
