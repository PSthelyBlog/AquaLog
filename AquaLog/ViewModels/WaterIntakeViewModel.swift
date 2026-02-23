import Foundation
import SwiftData

/// ViewModel for managing water intake data and calculations
@MainActor
@Observable
final class WaterIntakeViewModel {
    /// Daily goal in milliliters (8 glasses × 250ml = 2000ml)
    static let dailyGoalML: Double = 2000.0
    
    /// Milliliters per standard glass
    static let standardGlassML: Double = 250.0
    
    private let modelContext: ModelContext
    
    /// Total water intake for today in milliliters
    private(set) var todayTotalML: Double = 0
    
    /// Number of glasses logged today (based on 250ml per glass)
    var glassesLoggedToday: Int {
        Int(todayTotalML / Self.standardGlassML)
    }
    
    /// Progress percentage toward daily goal (0.0 to 1.0+)
    var progressPercentage: Double {
        min(todayTotalML / Self.dailyGoalML, 1.0)
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// Fetches today's total water intake
    func fetchTodayTotal() async {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? Date()
        
        let descriptor = FetchDescriptor<WaterIntake>(
            predicate: #Predicate { intake in
                intake.timestamp >= startOfDay && intake.timestamp < endOfDay
            }
        )
        
        do {
            let todayIntakes = try modelContext.fetch(descriptor)
            todayTotalML = todayIntakes.reduce(0) { $0 + $1.amountML }
        } catch {
            print("Error fetching today's water intake: \(error)")
            todayTotalML = 0
        }
    }
    
    /// Adds a new water intake entry
    /// - Parameter amountML: Amount of water in milliliters (defaults to one glass)
    func logWaterIntake(amountML: Double = 250.0) async {
        let intake = WaterIntake(amountML: amountML)
        modelContext.insert(intake)
        
        do {
            try modelContext.save()
            await fetchTodayTotal()
        } catch {
            print("Error saving water intake: \(error)")
        }
    }
    
    /// Deletes a water intake entry
    /// - Parameter intake: The intake entry to delete
    func deleteIntake(_ intake: WaterIntake) async {
        modelContext.delete(intake)
        
        do {
            try modelContext.save()
            await fetchTodayTotal()
        } catch {
            print("Error deleting water intake: \(error)")
        }
    }
}
