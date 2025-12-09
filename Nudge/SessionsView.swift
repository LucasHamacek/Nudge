//
//  SessionsView.swift
//  Nudge
//
//  Created by Joao Hamacek on 09/12/25.
//

import SwiftUI

struct SessionsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "timer")
                    .font(.system(size: 56, weight: .semibold))
                    .foregroundStyle(.accent)

                Text("Sessions")
                    .font(.largeTitle.bold())

                Text("Configure and start a focused session.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()

                Button {
                    // Placeholder para iniciar uma sessão
                } label: {
                    Text("Start Session")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.medium)
                    }
                    .accessibilityLabel("Close")
                }
            }
        }
    }
}

#Preview {
    SessionsView()
}

