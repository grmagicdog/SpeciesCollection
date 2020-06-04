//
//  RegularExpression.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/05/18.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

import Foundation

extension String {
    //正規表現の一致判断
    func match(pattern:RegexPattern) -> Bool {
        let pattern = pattern.rawValue
        let regex = try! NSRegularExpression(pattern:pattern)
        return regex.firstMatch(in:self, range:NSRange(self.startIndex..., in:self)) != nil
    }
    
    //両端のタグの削除
    func strip() -> String {
        let lstrip = self.replacingOccurrences(of:"^<\\w+>", with:"", options:NSString.CompareOptions.regularExpression, range:self.range(of:self))
        return lstrip.replacingOccurrences(of:"</\\w+>$", with:"", options:NSString.CompareOptions.regularExpression, range:lstrip.range(of:lstrip))
    }
}

//タグの定義
enum RegexPattern: String {
    case image = "^<image>.*</image>$"
    case caption = "^<caption>.*</caption>$"
}
