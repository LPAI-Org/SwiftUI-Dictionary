import SwiftUI

struct LongPressedGesture_function: View {
    
    @State var isComplete: Bool = false
    
    @State var isSuccess: Bool = false
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? .green:.blue)
                .frame(maxWidth: isComplete ? .infinity:0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            
            HStack {
                Text("CLICK HERE")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                .cornerRadius(10)
                //MARK: onLongPressGesture
                ///maximumDistance is the distance of where the user taps on the button and while holding down how far they can move their thumb/mouse before it cancels out
                .onLongPressGesture(minimumDuration: 1, maximumDistance: 50, perform: {
                    
                    //at the min duration
                    
                    withAnimation(.easeInOut) {
                        isSuccess = true
                    }
                    
                    
                }, onPressingChanged: {
                    isPressing in
                    //start of press -> min duration
                    if isPressing {
                        withAnimation(.easeOut(duration: 1)) {
                            isComplete = true
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            if !isSuccess {
                                withAnimation(.easeInOut) {
                                    isComplete = false
                                }
                            }
                        })
                    }
                })
                
                Text("RESET")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
            
            
            
        }
        
   
        
        
//        Text(isComplete ? "Completed":"Not Completed")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? .green:.gray)
//            .cornerRadius(10)
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 2, maximumDistance: 500, perform: {
//                isComplete.toggle()
//
//            })
        
        
    }
}

struct onLongPressedGesture_Previews: PreviewProvider {
    static var previews: some View {
        LongPressedGesture_function()
    }
}
