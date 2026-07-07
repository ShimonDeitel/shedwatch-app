import Foundation

struct ShedEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var structure: String = ""
    var issue: String = ""
    var date: Date = Date()
}
