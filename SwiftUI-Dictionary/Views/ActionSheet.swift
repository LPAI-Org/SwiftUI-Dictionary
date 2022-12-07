//Action Sheet - The method to get a pop up from below the screen by showing different buttons and messages

import SwiftUI

struct ActionSheet_View: View {
    
    @State var showActionSheet: Bool = false
    @State var actionSheetOptions: ActionSheetOptions = .isOtherPost
    
    enum ActionSheetOptions {
        case isMyPost, isOtherPost
    }
    
    var body: some View {
        VStack {
            HStack {
               Circle()
                    .frame(width: 30, height: 30)
                    
                Text("@username")
                Spacer()
                Button {
                    //the action toggle between enums below would set a different action button to pop up between .isOtherPost & .isMyPost
                    actionSheetOptions = .isOtherPost
                    showActionSheet.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                }

                
            }.padding(.horizontal)
            Rectangle()
                .aspectRatio(1.0, contentMode: .fit)
        }
        //MARK: ActionSheet
        .actionSheet(isPresented: $showActionSheet) {
            getActionSheet()
        }
    }
    
    //MARK: Action Sheet Function
    func getActionSheet() -> ActionSheet {
        //Different buttons to add to our ActionSheet
        let shareButton: ActionSheet.Button = .default(Text("Share")) {
            //code
        }
        
        let reportButton: ActionSheet.Button = .destructive(Text("Report")) {
            //code
        }
        
        let deleteButton: ActionSheet.Button = .destructive(Text("Delete")) {
            //code
        }
        
        let cancelButton: ActionSheet.Button = .cancel(Text("Cancel")) {
            //code
        }
        
        let title = Text("What would you like to do?")
        //Using a switch statement to toggle between different views based on the conditional logic to toggle actionSheetOptions = .isOtherPost / .isMyPost
        switch actionSheetOptions {
        case .isOtherPost:
          return  ActionSheet(title: title, message: nil, buttons: [shareButton, reportButton, cancelButton])
        case .isMyPost:
            return ActionSheet(title: title, message: nil, buttons: [shareButton, deleteButton, cancelButton])
        }
        
//        let button1:ActionSheet.Button = .default(Text("Default"))
//        let button2: ActionSheet.Button = .destructive(Text("Destructive"))
//        let button3: ActionSheet.Button = .cancel(Text("Cancel"))
//
//        //Example of how many buttons you can add in an action sheet
        
//        return ActionSheet(title: Text("SomeText"), message: Text("SomeMessage"), buttons: [button1, button1, button1, button2,button2,button2,button2, button3])
        
        
    }
}

struct ActionSheet_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheet_View()
    }
}
