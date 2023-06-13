//
//  MenuView.swift
//  pgsdk-ios
//
//  Created by TIEW SHAO YANG on 6/6/2023.
//

import SwiftUI

struct MenuView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showingAlert = false
    @State private var alertItem: AlertItem?
    
    func getContact()->String{
        var text = "\n"
        if let serviceTel = Pgoo.shared.config?.serviceTel, !serviceTel.isEmpty {
            text += "TEL: \(serviceTel)\n"
        }
        if let serviceQq = Pgoo.shared.config?.serviceQq, !serviceQq.isEmpty {
            text += "QQ: \(serviceQq)\n"
        }
        if let serviceWx = Pgoo.shared.config?.serviceWx, !serviceWx.isEmpty {
            text += "微信: \(serviceWx)\n"
        }
        if let serviceLine = Pgoo.shared.config?.serviceLine, !serviceLine.isEmpty {
            text += "Line: \(serviceLine)\n"
        }
//        text.dropLast(2)
        return text;
    }
    
    var body: some View {
        Text("菜單")
            .font(.title)
            .fontWeight(.bold)
            .padding()
        if let userName = Pgoo.shared.auth?.gameUser?.nickName as? String{
            Text("用户名:" + userName)
                .font(.title3)
                .fontWeight(.bold)
                .padding()
            Button(action: {
                self.alertItem = AlertItem(title: "联系客服", message: getContact())
            }) {
                Text("联系客服")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }.alert(item: $alertItem) { currentItem in
                Alert(title: Text(currentItem.title), message: Text(currentItem.message), dismissButton: .default(Text("OK")))
            }
            .padding(.bottom, 10)
            Button(action: {
                Pgoo.shared.signOut()
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Pgoo.shared.state.isShowingMenuView = false
                    Pgoo.shared.state.isShowingLoginView = true
                }
            }) {
                Text("退出登录")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding(.bottom, 10)
            
        }else{
            Text("未登录")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
        }
        Button(action: {
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
                Pgoo.shared.state.isShowingFloatButton = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Pgoo.shared.state.isShowingMenuView = false
            }
        }) {
            Text("隐藏悬浮窗")
                .foregroundColor(Color.white)
                .padding()
                .background(Color.black)
                .cornerRadius(12)
        }
        .padding(.bottom, 10)
        Button(action: {
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                Pgoo.shared.state.isShowingMenuView = false
            }
        }) {
            Text("关闭菜单")
                .foregroundColor(Color.white)
                .padding()
                .background(Color.black)
                .cornerRadius(12)
        }
        .padding(.bottom, 10)
    }
    
    struct AlertItem: Identifiable {
        var id = UUID()
        var title: String
        var message: String
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
