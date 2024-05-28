//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct NavigationView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.selectedTab) {
                Group {
                    MyInfoView()
                        .tabItem {
                            Label(
                                ViewModel.tabs[0],
                                systemImage: "person"
                            )
                        }
                        .tag(ViewModel.tabs[0])
                    UsedDaysView()
                        .tabItem {
                            Label(
                                ViewModel.tabs[1],
                                systemImage: "calendar"
                            )
                        }
                        .tag(ViewModel.tabs[1])
                    OrganizationView()
                        .tabItem {
                            Label(
                                ViewModel.tabs[2],
                                systemImage: "circle.hexagongrid"
                            )
                        }
                        .tag(ViewModel.tabs[2])
                }
                .background(BackgroundImage(opacity: 0.05))
                .toolbarBackground(Color(.toolbar), for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.selectedTab)
            .toolbar {
                Button(
                    action: {
                        viewModel.isLogoutDialogShown = true
                    }
                ) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .imageScale(.medium)
                        .bold()
                        .foregroundColor(.light)
                        .frame(minWidth: Dimensions.minTouchTarget, minHeight: Dimensions.minTouchTarget)
                }
            }
            .toolbarBackground(Color(.toolbar), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .alert(
                "Logout",
                isPresented: $viewModel.isLogoutDialogShown
            ) {
                Button("Cancel", role: .cancel) {}
                Button("Yes", role: .destructive) {
                    viewModel.logout()
                }
            } message: {
                Text("Are you sure?")
            }
        }
    }
}

#Preview {
    NavigationView()
}
