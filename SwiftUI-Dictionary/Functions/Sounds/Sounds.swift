import SwiftUI
//need AVKit (A = Audio, V = Video)
import AVKit

/*
 sound api:
 
 1. 
 
 */

//class is not an observableObject because we are not updating the view but rather grabbing something out of this class whenever needed
class SoundManager {
    
    //using an enum to switch between the different sound files
    enum SoundOptions: String {
        case tada = "tada", badum = "badum"
    }

    //instead of initializing the class in the view which causes to pre-render the class every time you call the view, we create a singleton in the class itself to avoid it from being called every time when we initialize the view but rather accessing the class through this static property whenever we need it.
    static let instance = SoundManager() //This is a singleton
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOptions) {
        //Calling Bundle.main.url because the sound files are within the bundle of our app (file-folders)
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch let error {
            print("There is an error: \(error.localizedDescription)")
        }
   
    }
}


struct Sounds: View {
    
    
    var body: some View {
        VStack(spacing: 20) {
            
            Button("Play Sound-1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            Button("Play Sound-2") {
                SoundManager.instance.playSound(sound: .badum)
            }
            
        }
    }
}

struct Sounds_Previews: PreviewProvider {
    static var previews: some View {
        Sounds()
    }
}
