//
// Created by Katarina Dokic
//

import Foundation

extension UsedDaysView {
    struct Data {
        typealias LeaveData = LeaveUsageView.Data

        let availablePto: Int
        let totalUsedPto: Int

        let calledInSick: LeaveData
        let personalLeave: LeaveData
        let patronSaintDay: LeaveData

        let onBusinessLeave: LeaveData

        let workedFromHome: LeaveData

        init(
            availablePto: Int = 0,
            totalUsedPto: Int = 0,
            calledInSick: Int = 0,
            personalLeave: Int = 0,
            patronSaintDay: Int = 0,
            onBusinessLeave: Int = 0,
            workedFromHome: Int = 0
        ) {
            self.availablePto = availablePto
            self.totalUsedPto = totalUsedPto
            self.calledInSick = LeaveData(
                iconName: "pills",
                iconTint: .darkRed,
                leaveType: "Sick Leave",
                usage: "\(calledInSick)"
            )
            self.personalLeave = LeaveData(
                iconName: "person.badge.clock",
                iconTint: .darkOrange,
                leaveType: "Personal Leave",
                usage: "\(personalLeave)"
            )
            self.patronSaintDay = LeaveData(
                iconName: "cross",
                iconTint: .darkYellow,
                leaveType: "Patron Saint Day",
                usage: "\(patronSaintDay) / 1"
            )
            self.onBusinessLeave = LeaveData(
                iconName: "briefcase",
                size: .large,
                iconTint: .green,
                leaveType: "Bussiness\nLeave",
                usage: "\(onBusinessLeave)"
            )
            self.workedFromHome = LeaveData(
                iconName: "house",
                size: .large,
                iconTint: .accent,
                leaveType: "Work from\nHome",
                usage: "\(workedFromHome)"
            )
        }
    }
}
