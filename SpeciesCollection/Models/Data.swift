//
//  Data.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/16.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

//データタイプ
enum SpeciesDataType {
    case data   //基本データ、随時変化
    case status //状態データ、保持
}

//リソースから基本データファイルを
let speciesData: [Species] = loadData("speciesData.json")

//状態データを読み込む
var speciesStatus: [Status] {
    //サンドボックスから状態データファイルを読み込む
    var status: [Status] = loadStatus("speciesStatus.json")
    
    //不足項目を初期化
    for species in speciesData {
        if status.firstIndex(where: { $0.id == species.id }) == nil {
            status.append(Status(id: species.id, isUnlocked: false, isFavorite: false))
        }
    }
    //サンドボックス内の状態データファイルを更新
    update(status, to: "speciesStatus.json")
    
    return status
}

//違うタイプのデータ間の連携に用いるインデックスの取得
func getIndex(for dataType: SpeciesDataType, id: Int) -> Int {
    switch dataType {
    case .data:
        return speciesData.firstIndex(where: {
            $0.id == id
        })!
    case .status:
        return speciesStatus.firstIndex(where: {
            $0.id == id
        })!
    }
}

//リソースからファイルの読み込み
func loadData<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    //ファイルのURLを取得
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
    
    //データを読み込む
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename):\n\(error)")
    }
    
    //データをデコード
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

//サンドボックスからファイルの読み込み
func loadStatus<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    //ファイルのURLを取得
    let dataUrl: URL = {
        let url = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first!
        let dataUrl = url.appendingPathComponent(filename)
        return dataUrl
    }()
    
    let fileManager = FileManager.default
    
    /* delete old file in sandbox to reset (debug)
    if fileManager.fileExists(atPath: dataUrl.path) {
        do {
            try fileManager.removeItem(at: dataUrl)
        } catch {
            fatalError("Couldn't remove \(dataUrl):\n\(error)")
        }
    }
    //end debug*/
    
    //ファイルがない時、空配列を返す
    if !fileManager.fileExists(atPath: dataUrl.path) {
        return [] as! T
    }
    
    //データを読み込む
    do {
        data = try Data(contentsOf: dataUrl)
    } catch {
        fatalError("Couldn't load \(filename):\n\(error)")
    }
    
    //データをデコード
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

//サンドボックス内のファイルの更新
func update<T: Encodable>(_ rawData: T, to filename: String) {
    
    //ファイルのURLを取得
    let file: URL = {
        let url = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first!
        let dataUrl = url.appendingPathComponent(filename)
        return dataUrl
    }()
    
    //データをエンコードし、ファイルに書き込む
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(rawData)
        try data.write(to: file)
    } catch {
        fatalError("Couldn't update \(file):\n\(error)")
    }
}
