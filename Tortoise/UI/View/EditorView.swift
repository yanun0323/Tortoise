import SwiftUI
import Ditto

struct EditorView: View {
    @Environment(\.injected) private var container: DIContainer
    
    @State private var env: Env
    @State private var inputName: String
    @State private var inputJson: String
    @State private var validInputName: Bool = false
    @State private var succeed: Bool? = nil
    @State private var allowSave: Bool = false
    
    init(env: Env) {
        self._inputName = .init(initialValue: env.name)
        self._inputJson = .init(initialValue: env.json() ?? "")
        self._env = .init(initialValue: env)
    }
    
    var body: some View {
        VStack {
            envNameView()
            HStack {
                inputView()
                previewView()
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func envNameView() -> some View {
        TextField("New Environment", text: $inputName)
            .font(.title)
            .textFieldStyle(.plain)
    }
    
    @ViewBuilder
    private func inputView() -> some View {
        VStack {
            TextEditor(text: $inputJson)
                .font(.system(size: 14))
            HStack {
                
                Button(width: 150, height: 30, color: .gray, radius: 5) {
                } content: {
                    Text("Cancel")
                        .foregroundColor(.white)
                }
                .shadow(radius: 3)
                
                Button(width: 150, height: 30, color: .blue, radius: 5) {
                } content: {
                    Text("Save")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    @ViewBuilder
    private func previewView() -> some View {
        VStack {
            EnvView(env: $env, size: Config.menuBarSize)
        }
    }
}

extension EditorView {
    func transferJson() -> Bool {
        guard let h = Env(inputJson) else {
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
    
    func handleInputJsonChanging() {
        
    }
    
    func handleInputNameChanging() {
//        let duplicated = container.interactor.data.checkDuplicateEnvName(inputName)
//        if duplicated {
//            validInputName = false
//            return
//        }
        validInputName = true
    }
}

#if DEBUG
#Preview {
    EditorView(env: .preview)
        .frame(size: Config.settingContentSize)
}
#endif
