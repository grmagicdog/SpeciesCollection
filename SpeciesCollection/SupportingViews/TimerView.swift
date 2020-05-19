//
//  TimerView.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    var time: Time
    
    var body: some View {
        Text(String(format: "%2d : %.2d : %.2d", time.hour, time.minute, time.second))
            .font(.system(size: 70))
            .frame(height: 248)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(time: UserData().setTime)
    }
}
