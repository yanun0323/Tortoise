import SwiftUI
import Ditto

struct SampleView: View {
    #if DEBUG
    @State private var input: String = Preview.json
    #else
    @State private var input: String = ""
    #endif
    @State private var succeed: Bool? = nil
    @State private var env: Env = .empty
    
    var body: some View {
        HStack {
            VStack {
                TextEditor(text: $input)
                    .font(.system(size: 14))
                Button(width: 150, height: 30, color: .blue, radius: 5) {
                    succeed = transferJson()
                    if !succeed! && env != .empty {
                        env = .empty
                    }
                } content: {
                    Text("Tranfer")
                        .foregroundColor(.white)
                }
                .shadow(radius: 3)

            }
            .frame(width: System.screen(.width, 0.45))
            
            VStack {
                EnvView(env: $env, width: System.screen(.width, 0.4), height: .infinity)
            }
            .frame(width: System.screen(.width, 0.45))
        }
        .padding()
    }
}

extension SampleView {
    func transferJson() -> Bool {
        guard let h = Env(input) else {
            if env != .empty {
                env = .empty
            }
            return false
        }
        env = h
        return true
    }
    
    func succeedInfo() -> String {
        guard let good = succeed else { return "-" }
        if good {
            return "good"
        }
        return "bad"
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
            .frame(size: Config.settingSize)
    }
}
#endif
