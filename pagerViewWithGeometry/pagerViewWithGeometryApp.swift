//
//  pagerViewWithGeometryApp.swift
//  pagerViewWithGeometry
//
//  Created by Amin on 7/5/1399 AP.
//

import SwiftUI

@main
struct pagerViewWithGeometryApp: App {
    @State var data = [1,3,5,6,5]
    @State var index = 0
    var body: some Scene {
        WindowGroup {
            PagerView3DEffect(selection: $index, data , spacing: 10) { int in
                Rectangle()
                    .foregroundColor(.red)
                    .cornerRadius(10)
                    .frame(width: 100, height: 100, alignment: .center)
                        
            }
        }
    }
}
