//
//  TimeSetterView.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI

struct TimeSetterView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        HStack {
            Picker(selection: $userData.setTime.hour, label: Text("1"), content: {
                ForEach(0..<24) {
                    Text(String($0))
                        .font(.title)
                }
            })
                .frame(width: 80.0)
                .clipped()
                .labelsHidden()
            Text("時間")
            .font(.title)
                .fontWeight(.medium)
            Picker(selection: $userData.setTime.minute, label: Text("1"), content: {
                ForEach(0..<60) {
                    Text(String($0))
                        .font(.title)
                }
            })
                .frame(width: 80.0)
                .clipped()
                .labelsHidden()
            Text("分")
                .font(.title)
                .fontWeight(.medium)
                
            }
        .padding()
    }
}

struct TimeSetterView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSetterView()
            .environmentObject(UserData())
    }
}
