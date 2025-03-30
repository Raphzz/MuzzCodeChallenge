import Foundation

struct MessageGroup: Identifiable {
    let id = UUID()
    let timestamp: Date
    var messages: [Message]
    
    var formattedTimestamp: String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(timestamp) {
            dateFormatter.dateFormat = "HH:mm"
            return String(format: "chat.timestamp.today".localized, dateFormatter.string(from: timestamp))
        } else if calendar.isDateInYesterday(timestamp) {
            dateFormatter.dateFormat = "HH:mm"
            return String(format: "chat.timestamp.yesterday".localized, dateFormatter.string(from: timestamp))
        } else {
            dateFormatter.dateFormat = "MMM d HH:mm"
            return dateFormatter.string(from: timestamp)
        }
    }
} 
