//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct OrganizationView: View {
    @State var viewModel = ViewModel()

    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.state.data) { userFields in
                    Section {
                        VStack(alignment: .leading, spacing: 0.0) {
                            ForEach(userFields.dataFields.elements, id: \.key) { fieldName, fieldValue in
                                VStack(spacing: 0.0) {
                                    HStack {
                                        Text(fieldName)
                                            .foregroundStyle(.dark)
                                            .padding(.leading, Dimensions.Spacing.standard)
                                        Text(fieldValue)
                                        Spacer()
                                    }.frame(minHeight: 50.0)
                                    Divider()
                                        .padding(.leading, Dimensions.Spacing.standard)
                                }
                            }
                        }.frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10.0)
                                    .stroke(Color(.gray), lineWidth: 2.0)
                            )
                    }
                }.listRowInsets(
                    EdgeInsets(
                        top: 0.0,
                        leading: 0.0,
                        bottom: 0.0,
                        trailing: 0.0
                    )
                )
            }.scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                .listSectionSpacing(Dimensions.Spacing.standard)
                .alert(
                    isPresented: $viewModel.state.isErrorDialogShown,
                    error: viewModel.state.error
                ) {
                    Button("OK", role: .cancel) {}
                }
            if (viewModel.state.isProgressViewShown) {
                OverlayProgressView()
            }
        }
    }
}

#Preview {
    OrganizationView()
}
