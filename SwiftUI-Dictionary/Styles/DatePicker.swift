import SwiftUI

struct DatePicker_Styles: View {
    //MARK: Store date
    @State var selectedDate: Date = Date()
    //Starting and ending date range
    let startingDate: Date = Calendar.current.date(from: DateComponents(year: 2018)) ?? Date.now
    let endingDate:Date = Date.now
    
    //MARK: Formatting Date Style
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter
    }
    
    
    var body: some View {
        List {
            VStack {
                //MARK: Date Display with formatter
                Text(dateFormatter.string(from: selectedDate))
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .background(.red)
                    .cornerRadius(30)
                
                //MARK: Date calendar picker
                Section("DatePicker1") {
                    DatePicker("Date: 1", selection: $selectedDate, displayedComponents: .date )
                        .tint(.green)
                    .datePickerStyle(.graphical)
                }
                .padding()
                .padding(.bottom, 30)
                
                //MARK: Date picker with time and day
                Section("DatePicker2") {
                    DatePicker("Date: 2", selection: $selectedDate, displayedComponents: [.hourAndMinute, .date])
                        .tint(.green)
                }.padding(.bottom, 40)
                
                
                //MARK: Date picker with only date and no time
                Section("DatePicker3") {
                    DatePicker("Date: 3", selection: $selectedDate, in: startingDate...endingDate, displayedComponents: .date)
                        .padding()
                }
                
            }
        }
        
        
    }
}

struct DatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DatePicker_Styles()
    }
}
