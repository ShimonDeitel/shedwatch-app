import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [ShedEntry] = []
    @Published var isPro: Bool = false

    /// Free-tier cap. Deliberately kept above the seed count so a fresh
    /// install never trips the paywall on first launch.
    static let freeLimit = 9

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Shedwatch", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("items.json")
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([ShedEntry].self, from: data) else {
            items = [
        ShedEntry(structure: "Sample Structure 1", issue: "Sample Issue 1", date: Date().addingTimeInterval(-604800)),
        ShedEntry(structure: "Sample Structure 2", issue: "Sample Issue 2", date: Date().addingTimeInterval(-1209600)),
        ShedEntry(structure: "Sample Structure 3", issue: "Sample Issue 3", date: Date().addingTimeInterval(-1814400))
            ]
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    @discardableResult
    func add(_ item: ShedEntry) -> Bool {
        guard canAddMore else { return false }
        items.insert(item, at: 0)
        save()
        return true
    }

    func update(_ item: ShedEntry) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: ShedEntry) {
        items.removeAll { $0.id == item.id }
        save()
    }
}
