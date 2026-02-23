import Foundation
import SwiftData

/// Represents a single water intake entry
@Model
final class WaterIntake {
    /// Unique identifier for the entry
    var id: UUID
    
    /// Amount of water consumed in milliliters
    var amountML: Double
    
    /// Timestamp when the water was consumed
    var timestamp: Date
    
    /// Initializes a new water intake entry
    /// - Parameters:
    ///   - amountML: Amount of water in milliliters (defaults to 250ml - one glass)
    ///   - timestamp: When the water was consumed (defaults to now)
    init(amountML: Double = 250.0, timestamp: Date = Date()) {
        self.id = UUID()
        self.amountML = amountML
        self.timestamp = timestamp
    }
    
    /// Convenience initializer that creates an entry for right now with default amount
    convenience init() {
        self.init(amountML: 250.0, timestamp: Date())
    }
}
