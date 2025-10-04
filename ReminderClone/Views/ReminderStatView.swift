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
                .background(Color.secondary)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
}

#Preview {
    ReminderStatView(icon: "calendar", title: "Today", count: 9)
}
