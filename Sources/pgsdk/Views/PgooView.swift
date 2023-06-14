import SwiftUI

public struct PgooView: View {
    @ObservedObject var state = Pgoo.shared.state
    public init() { }
    public var body: some View {
        if state.isShowingRealVerifyView {
            RealVerifyView()
        } else if state.isShowingLoginView {
            LoginView()
        } else if state.isShowingMenuView{
            MenuView()
        }
    }
}
