import SwiftUI
import InputBarAccessoryView

struct InputBarView: UIViewRepresentable {
    @Binding var text: String
    let onSend: () -> Void
    
    func makeUIView(context: Context) -> InputBarAccessoryView {
        let inputBar = InputBarAccessoryView()
        inputBar.delegate = context.coordinator
        inputBar.inputTextView.placeholder = "chat.message.placeholder".localized
        inputBar.sendButton.setTitle("chat.send.message".localized, for: .normal)
        inputBar.sendButton.setTitleColor(Theme.mainColor, for: .normal)
        return inputBar
    }
    
    func updateUIView(_ uiView: InputBarAccessoryView, context: Context) {
        uiView.inputTextView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: InputBarAccessoryViewDelegate {
        var parent: InputBarView
        
        init(_ parent: InputBarView) {
            self.parent = parent
        }
        
        func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
            parent.text = text
            parent.onSend()
            inputBar.inputTextView.text = ""
        }
    }
} 