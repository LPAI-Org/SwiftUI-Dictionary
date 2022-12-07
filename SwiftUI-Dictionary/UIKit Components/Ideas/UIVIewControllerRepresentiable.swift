//Below we created the ability to access the users photo album in order to grab an image and paste it back into our SwiftUI View

import SwiftUI

struct UI_ViewController_Representable: View {
    
    @State private var showScreen: Bool = false
    
    @State private var image: UIImage? = nil
    var body: some View {
        VStack {
            
            Text("Hi")
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            Button {
                showScreen.toggle()
            } label: {
                Text("Click here")
            }.sheet(isPresented: $showScreen) {
//                BasicUIViewControllerRep(localLabelText: "New Text Order")
                UIImagePickerControllerRep(showScreen: $showScreen, image: $image)
            }

        }
    }
}

//MARK: UIImagePickerController
///UIImagePickerController is one of the features that is not available in SwiftUI which  comes handy in UIKit. This accesses the phones photo library
struct UIImagePickerControllerRep: UIViewControllerRepresentable {
    
    @Binding var showScreen: Bool
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
    
        let vc = UIImagePickerController()
        //play with this boolean to see what it does
        vc.allowsEditing = false
        
        //we are accessing the makeCoordinator() through makeUIViewController property 'context' below as 'context.coordinator'
        vc.delegate = context.coordinator
        return vc
    }
    //MARK: Updates from SwiftUI to UIKit
    ///note: to update from SwiftUI to UIKit is not used very often in 'UIViewControllerRepresentable' but rather more often in the 'UIViewRepresentable ' which was used in the example where we updated the UIKit-TextField version from SwiftUI
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //
    }
    
    
    
    //makeCoordinator creates the custom instance that you use to communicate changes from your view controller to other parts of your swiftUI Interface
    //MARK: Updates from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showScreen: $showScreen)
    }
    
    ///This coordinator is now in charge of UIImagePickerController() above
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var image: UIImage?
        @Binding var showScreen: Bool
        
        init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
            self._image = image
            self._showScreen = showScreen
        }
    
        //MARK: Function to access photo album through UIImagePickerController & [UIImagePickerController.InfoKey : Any]
        //call the function imagePickerController and the rest will auto complete
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let newImage = info[.originalImage] as? UIImage else { return }
            image = newImage
            //showScreen = false basically removes the screen once you selected the image
           showScreen = false
        }
        
    }
    
}


//MARK: BasicUIViewControllerRep
///Second example on accessing UI Controller in order to update the text coming from UIKit in MyFirstViewController class below
struct BasicUIViewControllerRep: UIViewControllerRepresentable {
    //String coming into localLabelText
    let localLabelText: String
    
    //UIKit -> SwiftUI
    func makeUIViewController(context: Context) -> some UIViewController {
        //all the commented code added to the class of MyFirstViewController
       let vc = MyFirstViewController()
        //localLabelText getting passed into vc.labelText which comes back into MyFirstViewController to display
       vc.labelText = localLabelText
        
       return vc
        
//        let vc = UIViewController()
//        vc.view.backgroundColor = .tintColor
//
//        //creating an initial property to pass in UILabel() functions so we can call upon them like . text., .textColor, etc and pass in data back into it to hold.
//        let label = UILabel()
//        label.text = labelText
//        label.textColor = UIColor.white
//        //and then we basically append it to the view / subViews by providing the label property
//        vc.view.addSubview(label)
//        //creating a frame for this data to display
//        label.frame = vc.view.frame
//
//        return vc
    }
    
    //SwiftUI -> UIKit
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
    
}

struct UIViewControllerRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        UI_ViewController_Representable()
    }
}



class MyFirstViewController: UIViewController {
    
    var labelText: String = "Starting Value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let label = UILabel()
        label.text = labelText
        label.textColor = UIColor.white
        //and then we basically append it to the view / subViews by providing the label property
        view.addSubview(label)
        //creating a frame for this data to display
        label.frame = view.frame
    }
}
