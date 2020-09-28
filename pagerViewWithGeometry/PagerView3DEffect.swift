//
//  ContentView.swift
//  pagerViewWithGeometry
//
//  Created by Amin on 7/5/1399 AP.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct PagerView3DEffect<Data: RandomAccessCollection, ElementView: View>: View where Data.Element: Hashable {
    @State var size:CGSize = .zero
    @GestureState private var translation:CGFloat = 0
    @Binding var pageIndex:Int
    var spacing:CGFloat? = 10
    
    private let data: Data
    private let itemView: (Data.Element) -> ElementView
    
    init(selection:Binding<Int>,_ data: Data,spacing:CGFloat? = 10, @ViewBuilder itemView: @escaping (Data.Element) -> ElementView) {
        self.data = data
        self.itemView = itemView
        self.spacing = spacing
        _pageIndex = selection
    }
    
    
    var body: some View {
        GeometryReader { fullView in
            HStack(spacing:spacing) {
                ForEach(self.data,id:\.self) { item in
                    GeometryReader { geo in
                        itemView(item)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                                }
                            )
                            .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: size.width)
                }
            }
            .offset(x: -CGFloat(self.pageIndex) * (size.width+spacing!))
            .offset(x: self.translation)
            .padding(.horizontal, (fullView.size.width - size.width) / 2)
            .gesture(DragGesture()
                        .updating(self.$translation, body: { (value, state, _) in
                            state = value.translation.width
                        })
                        .onEnded({ (value) in
                            let offset = value.translation.width/(fullView.size.width/2)
                            let newIndex = (CGFloat(self.pageIndex) - offset).rounded()
                            self.pageIndex = min(max(Int(newIndex), 0), self.data.count - 1)
                        })
            )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.size = preferences
        }
        .onChange(of: pageIndex, perform: { value in
            print(value)
        })
        .animation(.spring())

    }
}

