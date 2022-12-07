import SwiftUI

struct OnAppear_and_OnDisappear: View {
    
    @State var myText: String = "My starting text"
    @State var count: Int = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text(myText)
                LazyVStack {
                    ForEach(1..<100) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 200)
                        
                        //MARK: OnAppear
                            .onAppear{
                            count += 1
                            }
                        //MARK: OnDisappear
                            .onDisappear {
                                onDisapppear()
                            }
                    }
                }
            }
            //MARK: OnAppear w/DispatchQueue
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    onText(newText: "On Appear text")
                })
                
                
            })
        }.navigationTitle("OnAppear & OnDisappear \(count)")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    //MARK: Functions
    func onDisapppear() {
        if count > 50 {
            count -= 10
        }
    }
    
    func onText(newText: String) {
        myText = newText
    }
}

struct OnAppear_and_OnDisappear_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OnAppear_and_OnDisappear()
        }
    }
}
