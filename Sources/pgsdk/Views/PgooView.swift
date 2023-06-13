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
