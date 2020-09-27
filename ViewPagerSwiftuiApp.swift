//
//  ViewPagerSwiftuiApp.swift
//  ViewPagerSwiftui
//
//  Created by Amin on 7/1/1399 AP.
//

import SwiftUI

@main
struct ViewPagerSwiftuiApp: App {
    let data = [MyData(),MyData(),MyData(),MyData(),MyData()]
    var body: some Scene {
        WindowGroup {
            PagerTabView(data:data) { data in
                Text("")
            }
        }
    }
}
