//
//
//  MoviesDB
//
//
//

import SwiftUI

public struct SpinnerCircle: View {
    private let colour: Color = .blue
    private var colourGradient: Color {
        colour.opacity(0.3)
    }

    public init() {}

    @State private var isAnimating = false

    public var body: some View {
        GeometryReader { geometry in
            let ringSize = min(geometry.size.width, geometry.size.height)
            ZStack {
                Circle()
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                colour.opacity(0),
                                colour.opacity(0.3),
                                colourGradient,
                                colour,
                                colour
                            ]),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )

                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(colour)
                    .offset(x: ringSize / 2)
            }
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(
                Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
            .onDisappear {
                isAnimating = false
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

private struct SpinnerCircle_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerCircle()
    }
}
