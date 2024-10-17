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
            TextField("검색어를 넣어주세요", text: self.$text)
                .padding(15)
                .padding(.horizontal,15)
                .background(Color.white)
                .cornerRadius(15)
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
                                    .padding()
                            }
                        }else{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(Color(.black))
                                .padding()
                        }
                        
                    }
                ).onTapGesture{
                    self.editText = true
                }
        }
    }
    
}

