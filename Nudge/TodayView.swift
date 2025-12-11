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
                        Text("Hi Lucas,")
                            .font(.body)

                        Text("Starting Fresh")
                            .font(.title)
                            .fontWeight(.bold)

                        Text("No pressure today - you`re building awareness just by being here.")
                            .font(.body)
                    }

                    Text("Flow")
                        .font(.headline)

                    // Dois cards lado a lado: Sessions e Now
                    HStack(spacing: 12) {
                        // Card: Sessions
                        NavigationLink {
                            SessionsView()
                        } label: {
                            CardView(
                                title: "Sessions",
                                subtitle: "3h 24m",
                                accent: .accentColor
                            )
                        }
                        .buttonStyle(.plain)

                        // Card: Now
                        Button {
                            // Ação do "Now" (placeholder)
                        } label: {
                            CardView(
                                title: "Now",
                                subtitle: "On a break",
                                accent: .green
                            )
                        }
                        .buttonStyle(.plain)
                    }

                    // Lista de apps mais usados hoje
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Flow Breakers")
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
                                    // Skeleton do ícone do app (placeholder do ícone real)
                                    AppIconSkeleton()
                                        .frame(width: 32, height: 32)

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
                    .padding(.vertical, 12)          // padding interno vertical da seção
                    .padding(.horizontal, 16)        // padding interno horizontal da seção
                    .background(.quinary)          // fundo da seção
                    .padding(.horizontal, -16)       // expande o fundo para a largura total (compensa o padding externo)
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

// Skeleton simples para ícone de app (substitui o ícone real enquanto não disponível)
private struct AppIconSkeleton: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(skeletonFill)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .strokeBorder(skeletonBorder, lineWidth: 0.8)
            )
    }

    private var skeletonFill: Color {
        colorScheme == .dark
        ? Color.white.opacity(0.08)
        : Color.black.opacity(0.06)
    }

    private var skeletonBorder: Color {
        colorScheme == .dark
        ? Color.white.opacity(0.12)
        : Color.black.opacity(0.10)
    }
}

private struct CardView: View {
    let title: String
    let subtitle: String
    let accent: Color

    @Environment(\.colorScheme) private var colorScheme

    private var corner: CGFloat { 22 }

    var body: some View {
        ZStack {
            // Base branca/dinâmica com sombra suave, como no Health
            RoundedRectangle(cornerRadius: corner, style: .continuous)
                .fill(cardBase)
                .overlay(
                    // Borda sutíl (quase imperceptível) para destacar do fundo
                    RoundedRectangle(cornerRadius: corner, style: .continuous)
                        .strokeBorder(cardBorder, lineWidth: 0.8)
                )
                .shadow(color: .black.opacity(colorScheme == .dark ? 0.45 : 0.10), radius: 16, x: 0, y: 8)
                .shadow(color: .black.opacity(colorScheme == .dark ? 0.25 : 0.03), radius: 2, x: 0, y: 0)

            // Conteúdo
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.primary)

                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                            .minimumScaleFactor(0.9)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.tertiary)
                }

                Spacer(minLength: 0)
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, minHeight: 140)
        .contentShape(RoundedRectangle(cornerRadius: corner, style: .continuous))
        .hoverEffect(.highlight)
    }

    private var cardBase: Color {
        colorScheme == .dark ? Color(.secondarySystemBackground) : .white
    }

    private var cardBorder: Color {
        colorScheme == .dark ? .white.opacity(0.08) : .black.opacity(0.06)
    }
}

#Preview {
    TodayView()
}
