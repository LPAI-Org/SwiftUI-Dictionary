import SwiftUI

struct ButtonStyle_and_ControlSize: View {
    var body: some View {
        VStack {
            //MARK: Button Variance
            Button("Button 1") {
                //no action
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .font(.headline)
            .buttonStyle(.plain)
            
            Button("Button 2") {
                //no action
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .font(.headline)
            .controlSize(.large)
            .buttonStyle(.bordered)
            
            Button("Button 3") {
                //no action
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .font(.headline)
            .controlSize(.small)
            .buttonStyle(.bordered)
            
            
            Button("Button 4") {
                //no action
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .font(.headline)
            .controlSize(.mini)
            .buttonStyle(.borderedProminent)
            
            Button("Button 5") {
                //no action
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .font(.headline)
            .controlSize(.regular)
            .buttonStyle(.borderedProminent)
            
            Button("Button 6") {
                //no action
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .font(.headline)
            .buttonStyle(.borderless)
            
            Button {
                //
            } label: {
                Text("Button 7")
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
                .controlSize(.large)
            
            
            //Most efficient and highly used is the one that has the custom label below. It gives a lot more control on how to style the buttons.
            Button {
                //
            } label: {
                Text("Button 8")
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
            
            Button {
                //
            } label: {
                Text("Button 9")
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 30))
                .controlSize(.large)

            
        }.padding()
    }
}

struct ButtonStyle_and_ControlSize_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStyle_and_ControlSize()
    }
}
