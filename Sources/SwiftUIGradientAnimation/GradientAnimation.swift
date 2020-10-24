import SwiftUI

public struct GradientAnimation: ViewModifier {
    // MARK: - Variables
    let gradient: Gradient
    let autoreverses: Bool
    
    // Define gradient start and end point
    @State private var startPoint: UnitPoint
    @State private var endPoint: UnitPoint
    
    // Start and end points on left and right
    private static let startPointLeft: CGFloat = -1
    private static let startPointRight: CGFloat = 0
    private static let endPointLeft: CGFloat = 1
    private static let endPointRight: CGFloat = 2
    
    private static let yAxisValue: CGFloat = 0.5
    
    // Direction control
    let leftToRight: Bool
    
    // Control gradient flow speed
    let flowSpeed: Double
    
    // MARK: - Initializers
    /// Initialize an animation with gradient colors directly.
    public init(gradientColors: [Color], flowSpeed: Double = 5, leftToRight: Bool = true, autoreverses: Bool = false) {

        gradient = Gradient(colors: gradientColors + gradientColors)
        
        self.autoreverses = autoreverses
        self.flowSpeed = flowSpeed
        
        self.leftToRight = leftToRight
        
        let startPointInitialValue = UnitPoint(x: leftToRight ? Self.startPointLeft : Self.startPointRight, y: Self.yAxisValue)
        let endPointInitialValue = UnitPoint(x: leftToRight ? Self.endPointLeft : Self.endPointRight, y: Self.yAxisValue)
        
        _startPoint = State(initialValue: startPointInitialValue)
        _endPoint = State(initialValue: endPointInitialValue)
    }
    
    /// Initialize an animation with gradient.
    public init(gradient: Gradient, flowSpeed: Double = 5, leftToRight: Bool = true, autoreverses: Bool = false) {
        self.gradient = Gradient(stops: gradient.stops + gradient.stops)
        
        self.autoreverses = autoreverses
        self.flowSpeed = flowSpeed
        
        self.leftToRight = leftToRight
        
        let startPointInitialValue = UnitPoint(x: leftToRight ? Self.startPointLeft : Self.startPointRight, y: Self.yAxisValue)
        let endPointInitialValue = UnitPoint(x: leftToRight ? Self.endPointLeft : Self.endPointRight, y: Self.yAxisValue)
        
        _startPoint = State(initialValue: startPointInitialValue)
        _endPoint = State(initialValue: endPointInitialValue)
    }
    
    // MARK: - View Bodies
    public func body(content: Content) -> some View {
        content.overlay(
            LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint)
        )
        .onAppear {
            startAnimation()
        }
        .mask(content)
    }
    
    // MARK: - Animation control
    private func startAnimation() {
        let animation = Animation.linear(duration: flowSpeed).repeatForever(autoreverses: autoreverses)
        
        withAnimation(animation) {
            startPoint.x = leftToRight ? Self.startPointRight : Self.startPointLeft
            endPoint.x = leftToRight ? Self.endPointRight : Self.endPointLeft
        }
    }
}
