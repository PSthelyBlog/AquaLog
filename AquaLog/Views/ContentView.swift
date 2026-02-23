//
//  ContentView.swift
//  AquaLog
//
//  Created by Philippe Sthely on 22/02/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: WaterIntakeViewModel?
    
    var body: some View {
        VStack {
            if let viewModel = viewModel {
                RingChartView(
                    currentCount: viewModel.glassesLoggedToday,
                    totalCount: 8,
                    onLogTap: {
                        Task {
                            await viewModel.logWaterIntake()
                        }
                    }
                )
            } else {
                ProgressView()
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = WaterIntakeViewModel(modelContext: modelContext)
                Task {
                    await viewModel?.fetchTodayTotal()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: WaterIntake.self, inMemory: true)
}
