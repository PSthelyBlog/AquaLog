import SwiftUI

struct RingChartView: View {
    let currentCount: Int
    let totalCount: Int
    let onLogTap: () -> Void
    
    private var progress: Double {
        guard totalCount > 0 else { return 0 }
        return Double(currentCount) / Double(totalCount)
    }
    
    var body: some View {
        VStack(spacing: 40) {
            // Ring Chart
            ZStack {
                // Background ring
                Circle()
                    .stroke(
                        Color.gray.opacity(0.2),
                        lineWidth: 20
                    )
                
                // Progress ring with gradient
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.blue, .cyan, .blue]),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: progress)
                
                // Center text
                VStack(spacing: 8) {
                    Text("\(currentCount)")
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("of \(totalCount) glasses")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 250, height: 250)
            
            // Log a Glass button
            Button(action: onLogTap) {
                HStack(spacing: 12) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 24))
                    
                    Text("Log a Glass")
                        .font(.system(size: 22, weight: .semibold, design: .rounded))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .cyan]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    VStack(spacing: 60) {
        // Empty state
        RingChartView(currentCount: 0, totalCount: 8, onLogTap: {})
        
        // Partial progress
        RingChartView(currentCount: 5, totalCount: 8, onLogTap: {})
        
        // Complete
        RingChartView(currentCount: 8, totalCount: 8, onLogTap: {})
    }
}
