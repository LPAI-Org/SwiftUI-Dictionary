import SwiftUI

class HapticManager {
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
        
    }
}

struct HapticManager_Functionality: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Section("Notifications:") {
                    Button("Success", action: { HapticManager.instance.notification(type: .success)})
                    Button("Warning", action: { HapticManager.instance.notification(type: .warning)})
                    Button("Error", action: { HapticManager.instance.notification(type: .error)})
                }
               
                Divider()
                Section("Impact:") {
                    Button("Soft", action: {HapticManager.instance.impact(style: .soft)})
                    Button("Light", action: {HapticManager.instance.impact(style: .light)})
                    Button("Medium", action: {HapticManager.instance.impact(style: .medium)})
                    Button("Rigid", action: {HapticManager.instance.impact(style: .rigid)})
                    Button("Heavy", action: {HapticManager.instance.impact(style: .heavy)})
                }
            }.navigationTitle("Haptics")
        }
    }
}

struct HapticManager_Previews: PreviewProvider {
    static var previews: some View {
        HapticManager_Functionality()
    }
}
