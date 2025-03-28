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
        inputBar.sendButton.setTitleColor(UIColor(Theme.mainColor), for: .normal)
        
        // Set initial height
        inputBar.frame.size.height = 70
        inputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        // Configure auto-sizing behavior
        inputBar.inputTextView.isScrollEnabled = false
        inputBar.inputTextView.delegate = context.coordinator
        inputBar.maxTextViewHeight = 100 // Maximum height when expanded
        
        return inputBar
    }
    
    func updateUIView(_ uiView: InputBarAccessoryView, context: Context) {
        uiView.inputTextView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, InputBarAccessoryViewDelegate, UITextViewDelegate {
        var parent: InputBarView
        
        init(_ parent: InputBarView) {
            self.parent = parent
        }
        
        func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
            parent.text = text
            parent.onSend()
            inputBar.inputTextView.text = ""
            
            // Reset height when sending message
            UIView.animate(withDuration: 0.3) {
                inputBar.frame.size.height = 70
                inputBar.layoutIfNeeded()
            }
        }
        
        // Handle text view height changes
        func textViewDidBeginEditing(_ textView: UITextView) {
            let inputBar = textView.superview?.superview as? InputBarAccessoryView
            inputBar?.invalidateIntrinsicContentSize()
        }
        
        func textViewDidChange(_ textView: UITextView) {
            let size = textView.sizeThatFits(CGSize(width: textView.bounds.width, height: .infinity))
            let newHeight = min(max(70, size.height + 16), 100) // 16 for padding
            
            let inputBar = textView.superview?.superview as? InputBarAccessoryView
            
            UIView.animate(withDuration: 0.3) {
                inputBar?.frame.size.height = newHeight
                inputBar?.layoutIfNeeded()
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            let inputBar = textView.superview?.superview as? InputBarAccessoryView
            
            // Return to default height when not focused and empty
            if textView.text.isEmpty {
                UIView.animate(withDuration: 0.3) {
                    inputBar?.frame.size.height = 70
                    inputBar?.layoutIfNeeded()
                }
            }
        }
    }
} 
