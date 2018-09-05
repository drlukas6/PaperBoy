//
//  GenericDataSource.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 27/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation

class GenericDataSource<T>: NSObject {
    var data: ObserverBox<[T]> = ObserverBox(observable: [])
}

