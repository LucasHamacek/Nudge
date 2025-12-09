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
        // Placeholder por enquanto
        return "Description"
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
                        dismiss()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: mode.icon)
                                .foregroundStyle(.accent)
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
                                    .foregroundStyle(.accent)
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Set Mode")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
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
