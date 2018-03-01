//
//  RoomDetail.swift
//
//  Created by suyash gupta on 27/02/18.
//  Copyright © 2018 Talentica. All rights reserved.
//

import Foundation
import ARKit

class RoomDetail:NSObject {
    
    public var roomName = ""
    public var roomDetail = ""
    public var roomDetail2 = ""
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
    }
    
    init(name: String){
        super.init()
        self.roomName = name
        if roomName == RoomDetail.rooms[0] {
            roomDetail = descDN
            roomDetail2 = descDN2
        }
    }
    
    public static let rooms = ["Donald Knuth","Alan Turing"]
    private let descDN = "Donald Ervin Knuth (/kəˈnuːθ/[4] kə-NOOTH; born January 10, 1938) is an American computer scientist,\n mathematician, and professor emeritus at Stanford University.\nHe is the author of the multi-volume work The Art of Computer Programming."
    private let descDN2 = "He contributed to the development of the rigorous analysis of the computational complexity of algorithms and\n systematized formal mathematical techniques for it. In the process he also popularized the asymptotic notation."
}

