//
//  ContentView.swift
//  UI_Dynamic Wave Animation_SwiftUI
//
//  Created by BitDegree on 19/12/24.
//

import SwiftUI

struct WaveAnimation: View {
    @State private var phase = 0.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<3) { i in
                    Wave(phase: phase + Double(i) * .pi / 2, amplitude: 20 + CGFloat(i * 10))
                        .stroke(Color.blue.opacity(Double(3 - i) / 3), lineWidth: 2)
                        .offset(y: geometry.size.height / 2 + CGFloat(i * 20))
                }
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    phase += .pi * 2
                }
            }
        }
    }
}

struct Wave: Shape {
    var phase: Double
    var amplitude: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midHeight = rect.height / 2
        let width = rect.width

        path.move(to: .zero)
        for x in stride(from: 0, through: width, by: 1) {
            let y = midHeight + sin((Double(x) / width * .pi * 2) + phase) * amplitude
            path.addLine(to: CGPoint(x: x, y: CGFloat(y)))
        }
        path.addLine(to: CGPoint(x: width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }

    var animatableData: Double {
        get { phase }
        set { phase = newValue }
    }
}
