import SwiftUI

extension View {
    public func gradientAnimation(gradientColors: [Color], flowSpeed: Double = 5, leftToRight: Bool = true, autoreverses: Bool = false) -> some View {
        
        let gradientAnimator = GradientAnimation(gradientColors: gradientColors, flowSpeed: flowSpeed, leftToRight: leftToRight, autoreverses: autoreverses)
        
        return self.modifier(gradientAnimator)
    }
    
    public func gradientAnimation(gradient: Gradient, flowSpeed: Double = 5, leftToRight: Bool = true, autoreverses: Bool = false) -> some View {
        
        let gradientAnimator = GradientAnimation(gradient: gradient, flowSpeed: flowSpeed, leftToRight: leftToRight, autoreverses: autoreverses)
        
        return self.modifier(gradientAnimator)
    }
    
    
    public func gradientAnimation(from startingHue: Double, to endingHue: Double, by strideInterval: Double = 0.01, saturation: Double = 1, brightness: Double = 1, flowSpeed: Double = 5, leftToRight: Bool = true, autoreverses: Bool = false) -> some View {
        let colorHues = stride(from: startingHue, to: endingHue, by: strideInterval)
        
        let colors = colorHues.map({ (hue) -> Color in
            Color(hue: hue, saturation: saturation, brightness: brightness)
        })
        
        return self.gradientAnimation(gradientColors: colors, flowSpeed: flowSpeed, leftToRight: leftToRight, autoreverses: autoreverses)
    }
    
    public func rainbowGradientAnimation(flowSpeed: Double = 5, saturation: Double = 1, brightness: Double = 1, leftToRight: Bool = true, strideInterval: Double = 0.01) -> some View {
        
        let hueStart: Double = 0
        let hueEnd: Double = 1
        
        
        return self.gradientAnimation(from: hueStart, to: hueEnd, by: strideInterval, saturation: saturation, brightness: brightness, flowSpeed: flowSpeed, leftToRight: leftToRight, autoreverses: false)
    }
}
