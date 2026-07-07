import SwiftUI

/// Bespoke palette for Shedwatch — tuned for its own domain, not shared.
enum Theme {
    static let accent = Color(red: 0.28, green: 0.28, blue: 0.12)
    static let accentSoft = Color(red: 0.60, green: 0.58, blue: 0.20)
    static let background = Color(red: 0.07, green: 0.07, blue: 0.04)
    static let card = Color(red: 0.07, green: 0.07, blue: 0.04).opacity(0.92)

    static let titleFont = Font.system(.largeTitle, design: .serif).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
