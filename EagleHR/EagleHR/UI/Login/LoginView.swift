//
// Created by Katarina Dokic
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Text("Hey,")
                        .font(.title2)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                HStack {
                    Text("Login")
                        .font(.title)
                        .foregroundStyle(Color(.dark))
                        .bold()
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    Text("to continue")
                        .font(.title)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                InputTextField(
                    placeholder: viewModel.state.email.placeholder,
                    iconName: viewModel.state.email.iconName,
                    input: $viewModel.state.email.content,
                    validationMsg: viewModel.state.email.validationMsg
                ).padding(.top, Dimensions.Spacing.large)
                InputTextField(
                    placeholder: viewModel.state.password.placeholder,
                    iconName: viewModel.state.password.iconName,
                    isSecure: true,
                    input: $viewModel.state.password.content,
                    validationMsg: viewModel.state.password.validationMsg
                ).padding(.top, Dimensions.Spacing.small)
                    .padding(.bottom, Dimensions.Spacing.standard)
                RoundButton(
                    title: "Login",
                    isEnabled: viewModel.state.isLoginEnabled,
                    action: viewModel.login
                ).padding(.top, Dimensions.Spacing.standard)
                Spacer()
            }
            .padding()
            .alert(
                isPresented: $viewModel.state.isErrorDialogShown,
                error: viewModel.state.error
            ) {
                Button("OK", role: .cancel) {}
            }
            OverlayProgressView()
                .hidden(!viewModel.state.isProgressViewShown)
        }.background(BackgroundImage(opacity: 0.3))
    }
}

#Preview {
    LoginView()
}
