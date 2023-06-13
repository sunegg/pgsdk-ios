import SwiftUI

public struct FloatButton: View {
    private let circleWidth = CGFloat(60)
    @State private var dragAmount = CGPoint(x: 0, y: 150)  // circleWidth / 2 is 30
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                Pgoo.shared.state.isShowingMenuView=true
            }, label: {
                ZStack{
                    Circle()
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                    
                    Image(systemName: "line.horizontal.3")
                }
            })
            .frame(width: circleWidth, height: circleWidth)
            .animation(.default)
            .position(self.dragAmount ?? CGPoint(x: geometry.size.width - circleWidth / 2, y: geometry.size.height - circleWidth / 2))
            .highPriorityGesture(DragGesture().onChanged {
                var location = $0.location
                let contant = CGFloat(0)
                if location.x < contant {
                    location.x = contant
                } else if location.x > geometry.size.width - contant {
                    location.x = geometry.size.width - contant
                }
                if location.y < contant {
                    location.y = contant
                } else if location.y > geometry.size.height - contant {
                    location.y = geometry.size.height - contant
                }
                self.dragAmount = location
            }.onEnded { _ in
                withAnimation(.spring()) {
                    self.dragAmount = CGPoint(x: 0, y: self.dragAmount.y)
                }
            })
        }
    }
}

struct FloatButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatButton()
    }
}
