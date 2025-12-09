//
//  TodayView.swift
//  Nudge
//
//  Created by Joao Hamacek on 09/12/25.
//

import SwiftUI

struct TodayView: View {
    @State private var showingSetModeSheet = false
    @State private var selectedMode: Mode = .balanced

    var body: some View {
        NavigationStack {
            Text("Today")
                .navigationTitle("Today")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showingSetModeSheet = true
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: selectedMode.icon)
                                Text(selectedMode.title)
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 4)
                        }
                        .accessibilityLabel("Set Mode")
                    }
                }
                .sheet(isPresented: $showingSetModeSheet) {
                    SetModeView(
                        selectedMode: $selectedMode
                    )
                    .presentationDetents([.medium])
                }
        }
    }
}

#Preview {
    TodayView()
}
