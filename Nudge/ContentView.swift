//
//  ContentView.swift
//  Nudge
//
//  Created by Joao Hamacek on 09/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "square.grid.2x2")
                }

            HabitsView()
                .tabItem {
                    Label("Habits", systemImage: "checkmark.circle")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }

    }
}

#Preview {
    ContentView()
}
