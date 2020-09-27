//
//  HeaderView.swift
//  ViewPagerSwiftui
//
//  Created by Amin on 7/2/1399 AP.
//

import SwiftUI

struct HeaderView: View {
    
    @StateObject var viewModel:monthHeaderViewModel
    let textSize:CGFloat = 100
    let spacing:CGFloat = 30
    
    func calculateOffset(geo:GeometryProxy) -> CGFloat {
        let starter = (geo.size.width/2) - textSize/2
        return starter
            + (-CGFloat(self.viewModel.index)) * (textSize+spacing)
    }
  
    
    @GestureState private var translation:CGFloat = 0
    @Binding var currentDate:Date
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing:spacing) {
                ForEach(viewModel.months) { item in
                    
                    Text("\(viewModel.title(date: item.date))")
                        .foregroundColor(item.isSelected ? .primary : .secondary )
                        .fontWeight(item.isSelected ? .bold : .none)
                        .multilineTextAlignment(.trailing)
                        .frame(width:textSize)
                        
                        .onTapGesture(count: 1, perform: {
                            withAnimation{
                                viewModel.tapped(on: item)
                            }
                        })
                    
                }
            }
            .frame(width:geo.size.width,alignment: .leading)
            .offset(x: calculateOffset(geo:geo))
            .offset(x:translation)
            .animation(.spring())
            .gesture(
                DragGesture(minimumDistance:0)
                    .updating(self.$translation, body: { (value, state, _) in
                        if abs(value.translation.width) < textSize + spacing + 20 {
                            state = value.translation.width
                           
                        }

                        print("\(value.translation.width)")
                    })
                    .onEnded({ (value) in

                        withAnimation{
                            if value.translation.width > 0 {
                                viewModel.increaseDate()
                            }else {
                                viewModel.decreaseDate()
                            }
                        }
                    })
                
            )
        }
    }
}

//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//    }
//}
