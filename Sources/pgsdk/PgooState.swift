import Foundation
import Combine

public  class PgooState: ObservableObject  {
    @Published public var isShowingFloatButton = true
        
    @Published public var isShowingMenuView = false {
        didSet {
            checkShowingPgooView()
        }
    }
    
    @Published public var isShowingLoginView = false {
        didSet {
            checkShowingPgooView()
        }
    }
    @Published public var isShowingRealVerifyView = false {
        didSet {
            checkShowingPgooView()
        }
    }
    @Published public var isShowingPgooView = false

    private var cancellableSet: Set<AnyCancellable> = []
    
    private func checkShowingPgooView() {
        isShowingPgooView = isShowingLoginView || isShowingRealVerifyView || isShowingMenuView
    }
}
