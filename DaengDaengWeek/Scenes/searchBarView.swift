//
//  searchBarView.swift
//  DaengDaengWeek
//
//  Created by 안준범 on 10/17/24.
//

import SwiftUI

struct searchBarView: View {
    @Binding var text: String
    @State var editText : Bool = false
    
    var body: some View {
        HStack{
            TextField("  검색어를 넣어주세요", text: self.$text)
                .frame(width: 258, height: 32)
                .font(.dw(.bold, size: 12))
                .background(Color.white)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .cornerRadius(6)
                .overlay(
                    HStack{
                        Spacer()
                        if self.editText{
                            Button(action : {
                                self.editText = false
                                self.text = ""
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }){
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color(.black))
                                    .padding(.trailing, 8)
                            }
                        }else{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.black))
                                .padding(.trailing, 8)
                        }
                        
                    }
                ).onTapGesture{
                    self.editText = true
                }
        }
    }
    
}

