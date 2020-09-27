//
//  ContentView.swift
//  ViewPagerSwiftui
//
//  Created by Amin on 7/1/1399 AP.
//

import SwiftUI

struct PagerTabView<Data:RandomAccessCollection,Content:View>:View where Data.Element : Identifiable {
    let data:Data
    let content:(Data.Element) -> Content
    let viewModel = monthHeaderViewModel()
    init(data:Data,@ViewBuilder content:@escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }
    @State var currentDate:Date = Date()
    
    
    @State var index:Int = 0
    var body: some View {
        
        VStack {
            HeaderView(viewModel:viewModel,currentDate:$currentDate)
                .frame(height:30)
//            content(data.first!)
            TabView(selection:$index) {
                ForEach(Array(data.enumerated()),id:\.element.id) { i,item in
                    Text("\(i)")
                        .frame(maxWidth:.infinity,maxHeight: .infinity)
                        .background(Color.red)
                        .tag(i)
                }
            }
            .background(Color.blue)
            .tabViewStyle(PageTabViewStyle())
            .onChange(of: index, perform: { value in
                print("index \(value)")
            })
        }
        
    }
}

//pagerView(headerData:data,contentData:data) { Transaction
//
//    LazyVGrid(columns: columns, alignment: .leading, spacing: 15, pinnedViews: [], content: {
//        if item.isEmpty {
//            Text(viewModel.dates[i],style: .date)
//                .tag(i)
//        }else{
//            VStack {
//            Text(viewModel.dates[i],style: .date)
//                .multilineTextAlignment(.center)
//            ForEach(item) { transaction in
//                    TransactionHomeCellView(transaction:transaction)
//                        .padding(.horizontal)
//                }
//            }
//            .tag(i)
//        }
//    })
//
//} headerLabel {
//    Text("")
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
