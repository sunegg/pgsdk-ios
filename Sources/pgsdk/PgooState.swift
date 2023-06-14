import Foundation
import Combine

public  class PgooState: ObservableObject  {
    @Published var isShowingFloatButton = true
        
    @Published var isShowingMenuView = false {
        didSet {
            checkShowingPgooView()
        }
    }
    
    @Published var isShowingLoginView = false {
        didSet {
            checkShowingPgooView()
        }
    }
    @Published var isShowingRealVerifyView = false {
        didSet {
            checkShowingPgooView()
        }
    }
    @Published var isShowingPgooView = false

    private var cancellableSet: Set<AnyCancellable> = []
    
    private func checkShowingPgooView() {
        isShowingPgooView = isShowingLoginView || isShowingRealVerifyView || isShowingMenuView
    }
}
