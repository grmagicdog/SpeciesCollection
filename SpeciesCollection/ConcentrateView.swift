//
//  ConcentrateView.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import SwiftUI

struct ConcentrateView: View {
    @EnvironmentObject var userData: UserData
    @State var timerEnabled = false
    
    var SwitchButtonText: [Bool : String] = [
        false : "開始",
        true : "取り消し"
    ]
    
    @State var timer: Timer?
    
    var body: some View {
        VStack {
            Spacer()
            if self.timerEnabled {
                TimerView(time: self.userData.remainedTime)
            }
            else {
                TimeSetterView()
            }
            Spacer()
            Button(action: {
                self.timerEnabled.toggle()
                if self.timerEnabled {
                    self.userData.remainedTime = self.userData.setTime
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if self.userData.remainedTime.timeUp {
                            timer.invalidate()
                        } else {
                            self.userData.remainedTime.second -= 1
                        }
                    }
                } else {
                    self.timer?.invalidate()
                }
            }) {
                Text(SwitchButtonText[self.timerEnabled]!)
                    .font(.largeTitle)
            }
            .disabled(userData.setTime.hour == 0 && userData.setTime.minute == 0)
            Spacer()
        }
    }
}

struct ConcentrateView_Previews: PreviewProvider {
    static var previews: some View {
        ConcentrateView()
            .environmentObject(UserData())
    }
}
