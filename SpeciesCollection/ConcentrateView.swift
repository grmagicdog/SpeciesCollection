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
    @State var isAllUnlocked = false
    
    //動的テキストのボタン
    var SwitchButtonText: Text {
        Text(!timerEnabled ? "開始" : "取り消し")
    }
    
    //充分な設置時間？
    var isTimeEnough: Bool {
        userData.setTime.hour > 0 || userData.setTime.minute >= 15
    }
    
    //動的イントロダクションテキスト
    var introductionText: Text {
        var text: Text
        if idLocked.count == 0 {
            text = Text("全生物を入手しました\nおめでとう！")
                .foregroundColor(.red)
        } else if isTimeEnough {
            text = Text("最後まで集中して\n新しい生物と出会いましょう")
            .foregroundColor(.green)
        } else {
            text = Text("一度15分未満の場合は\n新しい生物の取得ができません")
            .foregroundColor(.red)
        }
        return text
            
            
    }

    @State var timer: Timer?
    @State var newDataIndex: Int!
    
    var body: some View {
        VStack {
            Spacer()
            
            introductionText
                .frame(width: 300)
                .font(.system(size: 20, weight: .regular, design: .default))
                .multilineTextAlignment(.center)
                .lineSpacing(8)
                .padding()
                
            if self.timerEnabled {
                TimeRemained(time: self.userData.remainedTime)
                    .frame(height: 300)
            }
            else {
                TimeSetter()
                    .frame(height: 285)
            }
            
            Spacer()
            
            //スイッチボタン
            Button(action: {
                self.timerEnabled.toggle()
                        
                if self.timerEnabled {
                    //設置時間を取得
                    self.userData.remainedTime = self.userData.setTime
                    
                    //１秒刻みのタイマー
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        if self.userData.remainedTime.timeUp {
                            //タイムアップ
                            timer.invalidate()
                            
                            if self.isTimeEnough {
                                self.unlockSpecies()
                            } else {
                                self.isAllUnlocked = idLocked.count == 0
                            }
                            
                            self.showAlert = true
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

            Spacer()
        }
        //タイムアップのアラート
        .alert(isPresented: $showAlert) {
            if self.isAllUnlocked {
                return Alert(title: Text("全生物を入手しています"),
                message: Text("アップデートをご期待ください！"),
                dismissButton: .default(Text("OK"))
                )
                
            } else if self.isTimeEnough {
                return Alert(title: Text("新規：\(self.userData.speciess[newDataIndex].jpnName)"),
                message: Text("すぐチェックしますか？"),
                //左ボタン：何もしない
                primaryButton: .cancel(Text("後で")),
                //右ボタン：コレクションを表示
                secondaryButton: .default(Text("チェック"), action: {
                  self.userData.tabSelection = 1
                }))
            } else {
                return Alert(title: Text("お疲れ様です"),
                message: Text("今度は15分以上の集中で新しい生物と出会いましょう！"),
                dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    //生物のアンロック
    func unlockSpecies() {
        //残りからランダムで一つ選択
        guard let id = idLocked.randomElement() else {
            self.isAllUnlocked = true
            return
        }
        
        //状態データを変更
        let index = getIndex(for: .status, id: id)
        self.userData.status[index].isUnlocked = true
        
        //状態データファイルを更新
        update(self.userData.status, to: "speciesStatus.json")
        
        //新規入手のアラートを表示
        self.newDataIndex = getIndex(for: .data, id: id)
    }
}

struct ConcentrateView_Previews: PreviewProvider {
    static var previews: some View {
        ConcentrateView()
            .environmentObject(UserData())
    }
}
