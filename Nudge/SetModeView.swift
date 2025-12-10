//
//  SetModeView.swift
//  Nudge
//
//  Created by Joao Hamacek on 09/12/25.
//

import SwiftUI

enum Mode: CaseIterable, Equatable, Identifiable {
    case focused
    case balanced
    case light
    case off

    var id: Self { self }

    var title: String {
        switch self {
        case .focused: return "Focused"
        case .balanced: return "Balanced"
        case .light: return "Light"
        case .off: return "Off"
        }
    }

    var description: String {
        switch self {
        case .focused: return "Alert sooner for deeper focus sessions"
        case .balanced: return "A steady rhythm of focus and breaks"
        case .light: return "A gentle pace for relaxed days"
        case .off: return "No limits - just mindful awareness"
        }
    }

    var icon: String {
        // Ícones do SF Symbols como sugestão visual
        switch self {
        case .focused: return "target"
        case .balanced: return "line.3.horizontal.decrease.circle"
        case .light: return "leaf"
        case .off: return "power"
        }
    }
}

struct SetModeView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedMode: Mode

    var body: some View {
        NavigationStack {
            List {
                ForEach(Mode.allCases) { mode in
                    Button {
                        selectedMode = mode
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: mode.icon)
                                .foregroundColor(.primary)
                                .frame(width: 24, height: 24)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(mode.title)
                                    .font(.headline)
                                Text(mode.description)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            if mode == selectedMode {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Título + descrição no centro da barra
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 2) {
                        Text("Set Mode")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Choose how intense you want your nudges to be.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.9)
                    }
                }

                // Botão "Done" ocupando a largura na barra inferior
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                }
            }
        }
    }
}

#Preview {
    StatefulPreviewWrapper(Mode.balanced) { binding in
        SetModeView(selectedMode: binding)
    }
}

// Helper para pré-visualização com @Binding
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    private let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
