import SwiftUI
import InputBarAccessoryView

struct InputBarView: UIViewRepresentable {

    // MARK: Binding properties

    @Binding var text: String

    // MARK: Public properties

    let onSend: () -> Void

    // MARK: Public functions

    func makeUIView(context: Context) -> InputBarAccessoryView {
        let inputBar = InputBarAccessoryView()
        inputBar.delegate = context.coordinator
        inputBar.inputTextView.placeholder = "chat.message.placeholder".localized
        inputBar.sendButton.setTitle("chat.send.message".localized, for: .normal)
        inputBar.sendButton.setTitleColor(UIColor(Theme.mainColor), for: .normal)
        
        return inputBar
    }
    
    func updateUIView(_ uiView: InputBarAccessoryView, context: Context) {
        uiView.inputTextView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // MARK: Coordinator

    class Coordinator: NSObject, InputBarAccessoryViewDelegate, UITextViewDelegate {
        var parent: InputBarView
        
        init(_ parent: InputBarView) {
            self.parent = parent
        }
        
        func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
            parent.text = text
            parent.onSend()
            inputBar.inputTextView.text = ""
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            let inputBar = textView.superview?.superview as? InputBarAccessoryView
            inputBar?.invalidateIntrinsicContentSize()
        }
    }
} 
