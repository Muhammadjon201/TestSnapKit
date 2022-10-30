//
//  Models.swift
//  TestSnapKit
//
//  Created by ericzero on 10/20/22.
//

import UIKit

class MyModel {
    let queArr2 = [
        Question(img: "airpods", ans: "Airpods"),
        Question(img: "appletv", ans: "AppleTV"),
        Question(img: "imac", ans: "iMac"),
        Question(img: "ipad", ans: "iPad"),
        Question(img: "iphone", ans: "iPhone"),
        Question(img: "iwatch", ans: "iWatch"),
        Question(img: "macbook", ans: "Macbook"),
        Question(img: "macstudio", ans: "MacStudio"),
        Question(img: "macmini", ans: "Mac-mini")
    ]
    lazy var queArr = queArr2.shuffled()
}

class Question{
    
    var imageName: String?
    var ansver: String?
    
    init(img: String, ans: String){
        self.imageName = img
        self.ansver = ans
    }
}


