//
//  ReminderStatView.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 04/10/25.
//

import SwiftUI

struct ReminderStatView: View {
    let icon:String
    let title:String
    let count:Int?
    var iconColor:Color = .blue
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            HStack {
                VStack {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                if let count = count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(colorScheme == .dark ? Color.darkGrayColor : Color.offWhite)
            .foregroundColor(colorScheme == .dark ? Color.offWhite : Color.darkGrayColor)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}

#Preview {
    Group {
        ReminderStatView(icon: "calendar", title: "Today", count: 9)
        ReminderStatView(icon: "calendar", title: "Today", count: 9)
            .environment(\.colorScheme, .dark)
    }
}
