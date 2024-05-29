//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct UsedDaysView: View {
    @State var viewModel = ViewModel()

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: Dimensions.Spacing.standard) {
                    VStack(spacing: Dimensions.Spacing.standard) {
                        HStack {
                            Text("Total usage")
                                .font(.headline)
                                .bold()
                            Spacer()
                        }.padding(.bottom, Dimensions.Spacing.small)
                        HStack(alignment: .bottom) {
                            Text("Paid time off")
                                .font(.subheadline)
                            Spacer(minLength: 0)
                            Gauge(
                                value: Double(viewModel.state.data.totalUsedPto),
                                in: Double(viewModel.state.data.totalUsedPto)...Double(viewModel.state.data.availablePto),
                                label: {
                                    Image(systemName: "hourglass")
                                },
                                currentValueLabel: { Text("\(viewModel.state.data.totalUsedPto)")},
                                minimumValueLabel: {
                                    Text("0")
                                },
                                maximumValueLabel: {
                                    Text("\(viewModel.state.data.availablePto)")
                                }
                            )
                            .gaugeStyle(.accessoryCircular)
                            .scaleEffect(1.5)
                            .tint(Gradient(colors: [.green, .yellow, .orange, .red]))
                            .padding(.trailing, 1.5*Dimensions.Spacing.margins)
                            .padding(.bottom, Dimensions.Spacing.small)
                        }
                    }
                    Divider()
                    HStack {
                        Text("Usage stats")
                        Spacer()
                    }
                    VStack(spacing: Dimensions.Spacing.small) {
                        LeaveUsageView(data: viewModel.state.data.personalLeave)
                        LeaveUsageView(data: viewModel.state.data.calledInSick)
                        LeaveUsageView(data: viewModel.state.data.patronSaintDay)
                    }
                    Divider()
                    HStack {
                        Text("Additional info")
                            .padding(.bottom, Dimensions.Spacing.small)
                        Spacer()
                    }
                    HStack(spacing: Dimensions.Spacing.small) {
                        LeaveUsageView(data: viewModel.state.data.onBusinessLeave).frame(minWidth: 0, maxWidth: .infinity)
                        LeaveUsageView(data: viewModel.state.data.workedFromHome).frame(minWidth: 0, maxWidth: .infinity)
                    }.frame(minWidth: 0, maxWidth: .infinity)
                }.padding(Dimensions.Spacing.margins)
            }
            if (viewModel.state.isProgressViewShown) {
                OverlayProgressView()
            }
        }
        .alert(
            isPresented: $viewModel.state.isErrorDialogShown,
            error: viewModel.state.error
        ) {
            Button("OK", role: .cancel) {}
        }
        .onAppear(perform: viewModel.fetchData)
    }
}

#Preview {
    UsedDaysView()
}
