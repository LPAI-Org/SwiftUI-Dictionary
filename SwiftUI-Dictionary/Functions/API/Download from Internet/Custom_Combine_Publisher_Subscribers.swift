import SwiftUI
import Combine

//MARK: ViewModel
class SubscriberViewModel: ObservableObject {
    @Published var count: Int = 0
    //cancellable will allow us to stop an ongoing publisher loop if a certain condition becomes true/false
    var cancellable = Set<AnyCancellable>()
    @Published var textFieldText: String = ""
    @Published var isTextFieldValid: Bool = false
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }

    
    func addButtonSubscriber() {
        //here we are listing to the $isTextFieldValid publisher and using the .combineLatest method to also listen to $count publisher at the same time
        $isTextFieldValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
                
            }
            .store(in: &cancellable)
        
    }
    func addTextFieldSubscriber() {
        // We can bind directly to a publisher and subscribe to it as we did with $textFieldText and added the sink/store that passes the logic being subscribed to into the publisher
        $textFieldText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .map { text in
                
                if text.count > 3 {
                    return true
                }else {
                    return false
                }
            }
        //Not So Best Practice
        /*
         
            Every time we get the boolean result from the if/else statement above, it gets stored by assigning it below to the isTextFieldValid property but it is not recommended to use the .assign modifier but rather the .sink method.
        
            //.assign(to: \.isTextFieldValid, on: self)
         
         */
        //Best Practice
            .sink(receiveValue: { [weak self] isValid in
                self?.isTextFieldValid = isValid
            })
            .store(in: &cancellable)
    }
    func setUpTimer() {
         Timer
            .publish(
                every: 1,on: .main,in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                /*
                 the guard let statement below removes the requirement of making the self in the rest of the code become optional in a [weak self] code block. In our case below where as
                 self.count += 1 should have read: 'self?.count += 1', if we didnt have the guard let statement.
                 */
                guard let self = self else { return }
                    //add one to count
                    self.count += 1
                    //if count adds up to 10, terminate.
//                if  self.count >= 10 {
//                    //we do a for loop to obtain all the modifiers. In our case, we need to cancel out of the loop if it reaches 10 by calling the .cancel modifier.
//                    for item in self.cancellables {
//                        item.cancel()
//                    }
//                }
            }
            .store(in: &cancellable)
    }
    
}




struct Custom_Combine_Publisher_Subscribers: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack{
            Text("\(vm.count)")
           // Text("\(vm.isTextFieldValid.description)")
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .background(.thinMaterial)
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0: vm.isTextFieldValid ? 0:1)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.isTextFieldValid ? 1:0)
                    }
                        .font(.title)
                        .padding(.trailing)
                    
                    , alignment: .trailing
                )
            
            Button(action: {
                //
            }, label: {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(
                        vm.showButton ? 1:0.5
                    )
            }).disabled(!vm.showButton)
        }
        .padding()
        }
}

struct Custom_Combine_Publisher_Subscribers_Previews: PreviewProvider {
    static var previews: some View {
        Custom_Combine_Publisher_Subscribers()
    }
}
