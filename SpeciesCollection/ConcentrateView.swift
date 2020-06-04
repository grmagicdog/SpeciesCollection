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
    
    //スイッチ変数
    @State var timerEnabled = false
    @State var showAlert = false
    
    //動的テキストのボタン
    var SwitchButtonText: Text{
        Text(!timerEnabled ? "開始" : "取り消し")
    }
    
    @State var timer: Timer?
    @State var newDataIndex: Int!
    
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
            
        //delete this when debug finished⬇️
            VStack {
        //delete this when debug finished⬆️
                    Button(action: {
                        self.timerEnabled.toggle()
                        
                        if self.timerEnabled {
                            self.userData.remainedTime = self.userData.setTime
                            
                            //１秒刻みのタイマー
                            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                if self.userData.remainedTime.timeUp {
                                    //タイムアップ
                                    timer.invalidate()
                                    self.unlockSpecies()
                                    self.timerEnabled = false
                                } else {
                                    //カウントダウン
                                    self.userData.remainedTime.second -= 1
                                }
                            }
                        } else {
                            self.timer?.invalidate()
                        }
                    }) {
                        SwitchButtonText
                            .font(.largeTitle)
                    }
                    .disabled(userData.setTime.hour == 0 && userData.setTime.minute == 0)
            //delete this when debug finished⬇️
                HStack {
                    Button(action: unlockSpecies) {
                        Text("Debug Unlock")
                    }
                    .padding()
                    Button(action: {
                        update([Status](), to: "speciesStatus.json")
                        
                    }) {
                        Text("Reset")
                    }
                }
            }
            //delete this when debug finished⬆️
            Spacer()
        }
        //新規入手のアラート
        .alert(isPresented: $showAlert) {
            Alert(title: Text("\(self.userData.speciess[newDataIndex].jpnName)を入手しました"),
                  message: Text("すぐチェックしますか？"),
                  //左ボタン：何もしない
                  primaryButton: .cancel(Text("後で")),
                  //右ボタン：コレクションを表示
                  secondaryButton: .default(Text("OK"), action: {
                    self.userData.tabSelection = 1
                  }))
        }
    }
    
    //生物のアンロック
    func unlockSpecies() {
        //残りからランダムで一つ選択
        guard let id = idLocked.randomElement() else {
            return
        }
        
        //状態データを変更
        let index = getIndex(for: .status, id: id)
        self.userData.status[index].isUnlocked = true
        
        //状態データファイルを更新
        update(self.userData.status, to: "speciesStatus.json")
        
        //新規入手のアラートを表示
        self.newDataIndex = getIndex(for: .data, id: id)
        self.showAlert = true
    }
}

struct ConcentrateView_Previews: PreviewProvider {
    static var previews: some View {
        ConcentrateView()
            .environmentObject(UserData())
    }
}
