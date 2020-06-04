//
//  Time.swift
//  SpeciesCollection
//
//  Created by 高瑞 on 2020/06/05.
//  Copyright © 2020 Rui Gao. All rights reserved.
//

struct Time {
    var timeUp = false
    var hour: Int = 0 {
        didSet {
            if hour < 0 {
                timeUp = true
                hour = 0
                minute = 0
                second = 0
            }
        }
    }
    var minute: Int = 30 {
        didSet {
            if minute < 0 {
                minute = 59
                hour -= 1
            }
        }
    }
    var second: Int = 0 {
        didSet {
            if second < 0 {
                second = 59
                minute -= 1
            }
        }
    }
}
