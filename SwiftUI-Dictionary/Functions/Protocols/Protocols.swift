import SwiftUI

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .purple
    var secondary: Color = .white
    var tertiary: Color = .teal
    
}

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

//MARK: Protocols
protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

//MARK: Protocol inheriting from two other protocols
protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol {
    
}

//Using the protocol that has inherited two other protocols for cleaner code
class DefaultDataSource: ButtonDataSourceProtocol {
    var buttonText: String = "Protocols are awesome!"
    
    func buttonPressed() {
        print("Button was pressed")
    }
}

class AlternativeDataSource: ButtonTextProtocol {
    
    var buttonText: String = "Protocols are tough!"
}

struct Protocols: View {
    
    ///Not using protocol below
   // let colorTheme: DefaultColorTheme = DefaultColorTheme()
   // let colorTheme: AlternativeColorTheme = AlternativeColorTheme()
    
    ///Using protocol below
    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonDataSourceProtocol
 
    
    var body: some View {
        ZStack {
            colorTheme.tertiary.ignoresSafeArea()
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundColor(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}

struct Protocols_Previews: PreviewProvider {
    static var previews: some View {
        Protocols(colorTheme: AnotherColorTheme(), dataSource: DefaultDataSource())
    }
}
