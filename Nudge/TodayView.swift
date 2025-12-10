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

    // Mock de apps mais usados no dia
    struct AppUsageItem: Identifiable {
        let id = UUID()
        let iconSystemName: String
        let appName: String
        let minutesUsed: Int
    }

    private var todaysTopApps: [AppUsageItem] = [
        .init(iconSystemName: "message.fill", appName: "Messages", minutesUsed: 42),
        .init(iconSystemName: "safari.fill", appName: "Safari", minutesUsed: 35),
        .init(iconSystemName: "paperplane.fill", appName: "Mail", minutesUsed: 28),
        .init(iconSystemName: "play.rectangle.fill", appName: "YouTube", minutesUsed: 55),
        .init(iconSystemName: "bubble.left.and.bubble.right.fill", appName: "WhatsApp", minutesUsed: 31)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Greeting + título + descrição
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hi User,")
                            .font(.default)

                        Text("Starting Fresh")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("No pressure today - you`re building awareness just by being here.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    NavigationLink {
                        SessionsView()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 36))
                                .foregroundStyle(.tint)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Sessions")
                                    .font(.headline)
                                Text("Start a focused session")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(.background.opacity(0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .strokeBorder(.quaternary, lineWidth: 1)
                                )
                        )
                    }
                    .buttonStyle(.plain)

                    // Lista de apps mais usados hoje
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Most used apps today")
                            .font(.headline)

                        // Usando LazyVStack para manter dentro do ScrollView
                        LazyVStack(spacing: 0) {
                            ForEach(Array(todaysTopApps.enumerated()), id: \.element.id) { index, item in
                                // Divider entre itens (exceto antes do primeiro)
                                if index > 0 {
                                    Divider()
                                        .padding(.leading, 56) // alinha com o texto (32 ícone + 12 spacing + margem)
                                }

                                HStack(spacing: 12) {
                                    Image(systemName: item.iconSystemName)
                                        .frame(width: 32, height: 32)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.tint)

                                    Text(item.appName)
                                        .font(.body.weight(.semibold))

                                    // Empurra o tempo para a extrema direita
                                    Spacer(minLength: 8)

                                    Text(formattedTime(minutes: item.minutesUsed))
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 16)
                                .padding(.horizontal, 12)
                            }
                            
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
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

    private func formattedTime(minutes: Int) -> String {
        let h = minutes / 60
        let m = minutes % 60
        if h > 0 {
            return String(format: "%dh %dm", h, m)
        } else {
            return String(format: "%dm", m)
        }
    }
}

#Preview {
    TodayView()
}
