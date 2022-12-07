import SwiftUI

struct Button_Views: View {
    var body: some View {
        
        VStack {
            //Button with styling by adding it to the label
            Button {
                //
            } label: {
                Image(systemName: "heart.fill").foregroundColor(.red)
                Text("Press Me")
            }
            .frame(width: 200, height: 200)
            .background(.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            //Button Styling by adding it within the labels elements i.e Text() with no frame
            
            Button(action: {
                //
            }, label: {
                Text("Hit Me")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                   
            })
            
            //Button with frame and styling added to the labels element i.e. Text()
            
            Button {
                //
            } label: {
                Text("Submit")
                .frame(width: 175, height: 150)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
            
            //Button2 with frame and styling added to the labels element i.e. Text()
            Button {
                //
            } label: {
                Text("Send")
                    .padding()
                    .padding(.horizontal, 10)
                    .background(Capsule().stroke(Color.gray, lineWidth: 2.0))
                    .foregroundColor(.red)
                    .shadow(color: .black, radius: 10, x: 1.6, y: 5.0)
                
            }

            
        }
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Button_Views()
    }
}
