import SwiftUI

struct Timer_with_onReceive: View {
    
    let color1 = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
    let color2 = Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))
    
    //MARK: Timer
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    ///Four Different ways to approach a timer countdown
    //1) Current Timer
    /*
     @State var date:Date = Date()
     var dateFormatter: DateFormatter {
     let formatter = DateFormatter()
     formatter.timeStyle = .medium
     formatter.dateStyle = .medium
     return formatter
     }
     */
    
    //2) CountDown
    /*
     @State var countDown: Int = 3
     @State var finishedText: String? = nil
     */
    
    //3) CountDown + Time
    /*
     @State var timeRemaining: String = ""
     
     /*
      In reality you wouldn't be passing a Calendar modifier into this property but rather a function that has a logic where it is storing the date, and how much time was left or when the 24 hours completes, etc.
     
      this logic below is taking one day ahead from todays date
     Two ways to change the countdown from counting down days, hours, minutes etc. as per the value "byAdding:___" parameter below
      */
     
     //first way:
       let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
     
     //second way:
     let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
     func updateTimeRemaining() {
     let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
     
     let hour = remaining.hour ?? 0
     let minute = remaining.minute ?? 0
     let second = remaining.second ?? 0
     //timeRemaining = "\(hour):\(minute):\(second)"
     timeRemaining = "\(minute):\(second)"
     }
     */
    
    //4) Animation Counter
    @State var count: Int = 0
    //~The End~
    var body: some View {
        
        ZStack {
            RadialGradient(gradient: Gradient(colors: [color1, color2]), center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            //One Version using timer
            TabView(selection: $count) {
                
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            
            //Second version using timer
            /*
                        HStack(spacing: 15){
                            Circle()
                                .offset(y: count == 1 ? -20: 0)
                            Circle()
                                .offset(y: count == 2 ? -20: 0)
                            Circle()
                                .offset(y: count == 3 ? -20: 0)
                        }.foregroundColor(.white)
                            .frame(width: 150)
            */
            /*
             
                Text(dateFormatter.string(from: date))
              Text(finishedText ?? "\(countDown)")
                         Text(timeRemaining)
                             .font(.system(size: 100, weight: .semibold, design: .rounded))
                             .foregroundColor(.white)
                         //lineLimits the line of strings on one line
                             .lineLimit(1)
                         //minimumScaleFactor would scale the size if it got too big
                             .minimumScaleFactor(0.1)
             */
            
        }
        //MARK: onReceive
        .onReceive(timer) { value in
            withAnimation(.easeInOut(duration: 1)) {
                //third way to update the timer (most comprehensive):
                count = count == 5 ? 0: count + 1
            }
            
            //one way to update the timer:
            //  date = value
            
            
            //second way to update the timer:
            //            if countDown <= 1 {
            //                finishedText = "Finito"
            //            }else {
            //                countDown -= 1
            //            }
            // updateTimeRemaining()
            
            //            if count == 3{
            //                count = 0
            //            }
            //            else {
            //                count += 1
            //            }
            
            
            
            
        }
    }
}

struct Timer_with_onReceive_Previews: PreviewProvider {
    static var previews: some View {
        Timer_with_onReceive()
    }
}
