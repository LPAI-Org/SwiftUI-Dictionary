import SwiftUI

/*
 
 Two types of Test
 
 1. Unit Tests
 
 - Tests the business logic in the app *more important*
 
 
 2. UI Tests
 
 - tests the UI in the app
 
 */



struct UnitTestingView: View {
    
    @StateObject private var vm: UnitTestingViewModel
        
    //Dependency Injection for View
    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestingView(isPremium: true)
    }
}
