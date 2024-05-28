//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct MyInfoView: View {
    @State var viewModel = ViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                List {
                    ForEach(viewModel.state.data.fields.elements, id: \.key) { (fieldId, field) in
                        HStack(alignment: .center) {
                            Text(fieldId.rawValue)
                                .font(.headline)
                                .foregroundStyle(.dark)
                            if (field.isEditable) {
                                InputTextField(
                                    input: .init(
                                        get: { viewModel.state.editableData.fields[fieldId]?.value ?? "" },
                                        set: { viewModel.state.editableData.fields[fieldId]?.value = $0 })
                                )
                            } else {
                                Text(field.value)
                                    .frame(minHeight: 40.0)
                            }
                        }
                    }.listRowBackground(
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.white)
                            .stroke(Color(.black), lineWidth: 2.0)
                    )
                }.listRowSpacing(20.0)
                    .scrollContentBackground(.hidden)
                Divider()
                    .shadow(
                        color: .dark,
                        radius: 1.0,
                        y: -2
                    )
                RoundButton(
                    title: "Save changes",
                    isEnabled: viewModel.state.isSaveChangesEnabled,
                    action: viewModel.updateInfo)
                .padding(.vertical, Dimensions.Spacing.standard)
            }.alert(
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
    MyInfoView()
}
