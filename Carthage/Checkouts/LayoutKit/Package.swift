// swift-tools-version:4.2
//
//  LayoutKit.swift
//  LayoutKit
//
//  Created by Vinicius França on 23/10/15.
//  Copyright © 2017 viniciusfranca. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "LayoutKit",
    products: [
        .library(
            name: "LayoutKit",
            targets: ["LayoutKit"]),
        ],
    dependencies: [],
    targets: [
        .target(
            name: "LayoutKit",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "LayoutKitTests",
            dependencies: ["LayoutKit"],
            path: "Tests"),
    ]
)
