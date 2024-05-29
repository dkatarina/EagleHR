//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct LeaveUsageView : View {
    @State var data: Data

    var body : some View {
        HStack {
            Image(systemName: data.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: data.iconSize, height: data.iconSize)
                .padding(.all, Dimensions.Spacing.small)
                .foregroundColor(data.iconTint)
                .background {
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(data.iconTint, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        .fill(data.iconTint.opacity(0.2))
                        .padding(.all, 2.0)
                }
            HStack {
                Text(data.leaveType)
                    .font(data.font)
                Spacer(minLength: 0)
                Text(data.usage)
                    .font(data.font)
                    .bold()
                    .padding(.trailing)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10.0)
                .stroke(.gray, lineWidth: 2.0)
                .fill(.white)
        }
    }
}

extension LeaveUsageView {
    struct Data {
        var iconName: String
        var iconSize: CGFloat
        var iconTint: Color
        var leaveType: String
        var usage: String
        var font: Font

        init(iconName: String, size: Size = .small, iconTint: Color, leaveType: String, usage: String) {
            self.iconName = iconName
            self.iconSize = switch size {
            case .small:
                15.0
            case .large:
                25.0
            }
            self.iconTint = iconTint
            self.leaveType = leaveType
            self.usage = usage
            self.font = switch size {
            case .small:
                .body
            case .large:
                .footnote
            }
        }
    }

    enum Size {
        case small
        case large
    }
}

#Preview {
    LeaveUsageView(
        data: LeaveUsageView.Data(
            iconName: "pills",
            iconTint: .darkRed,
            leaveType: "Sick Leave",
            usage: "10"
        )
    )
}
