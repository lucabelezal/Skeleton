//
//  Result.swift
//  Networking
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(NetworkResponse)
}
