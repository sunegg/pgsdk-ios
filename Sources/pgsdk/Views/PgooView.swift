//  PgooView.swift
//  pgsdk-ios
//
//  Created by TIEW SHAO YANG on 11/6/2023.
//

import SwiftUI

struct PgooView: View {
    @ObservedObject var state = Pgoo.shared.state

    var body: some View {
        if state.isShowingRealVerifyView {
            RealVerifyView()
        } else if state.isShowingLoginView {
            LoginView()
        } else if state.isShowingMenuView{
            MenuView()
        }
    }
}
