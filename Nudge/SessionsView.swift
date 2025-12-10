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
            // Conteúdo vazio por enquanto, já que o título/subtítulo vão no topo
            Color.clear
                .ignoresSafeArea()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack(spacing: 2) {
                            Text("Sessions")
                                .font(.headline.weight(.semibold))
                                .lineLimit(1)
                                .truncationMode(.tail)

                            Text("Date")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                    }
                }
        }
    }
}

#Preview {
    SessionsView()
}

