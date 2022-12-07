import SwiftUI

struct DragGesture2: View {
    
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.87
    @State var endingOffsetY: CGFloat = 0
    @State private var currentDragOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            SignUpView(currentDragOffset: $currentDragOffset, endingOffsetY: $endingOffsetY)
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffset)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture().onChanged({ value in
                        withAnimation(.spring()) {
                            currentDragOffset = value.translation.height
                        }
                    })
                    .onEnded({ value in
                        withAnimation(.spring()) {
                        if currentDragOffset < -150 {
                            endingOffsetY = -startingOffsetY
                        } else if endingOffsetY != 0 && currentDragOffset > 150 {
                          endingOffsetY = 0
                            currentDragOffset = 0
                        }
                            currentDragOffset = 0
                        }
                    })
                )
            
//            VStack {
//                HStack {
//                    Text("Current")
//                    Text("\(currentDragOffset)")
//                }
//                HStack {
//                    Text("Ending")
//                    Text("\(endingOffsetY)")
//                }
//                Spacer()
//            }
            
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGesture2_Previews: PreviewProvider {
    static var previews: some View {
        DragGesture2()
    }
}

struct SignUpView: View {
    
    @Binding var currentDragOffset: CGFloat
    @Binding var endingOffsetY: CGFloat
    
    var body: some View {
        VStack(spacing: 20) {
            
    
            
            if endingOffsetY != 0 {
                Image(systemName: "chevron.down").padding(.top, 20)
            } else {
                Image(systemName: "chevron.up")
                    .offset(y: currentDragOffset)
                    .offset(y: endingOffsetY)
                    .padding(.top)
            }
            Text("Sign Up")
                .offset(y: currentDragOffset)
                .offset(y: endingOffsetY)
                .font(.headline)
                .fontWeight(.semibold)
//                .onTapGesture {
//
//                    if currentDragOffset == -450 {
//                        withAnimation(.spring()) {
//                            currentDragOffset -= endingOffsetY
//                            }
//                        } else if endingOffsetY == 0 && currentDragOffset == 0 {
//                            withAnimation(.spring()) {
//                                currentDragOffset = -450
//                        }
//                        } else {
//                            currentDragOffset = 0
//                        }
//                }
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app. Most Favorite SwiftUI course, and highly recommend to all my friends to subscribe to SwiftFul Thinking")
                .multilineTextAlignment(.center)
            
            Text("CREATE AN ACCOUNT").background(Color.black.cornerRadius(10))
                .foregroundColor(Color.white)
                .padding()
                .font(.headline)
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
