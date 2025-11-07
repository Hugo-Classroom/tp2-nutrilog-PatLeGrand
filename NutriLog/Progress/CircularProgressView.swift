//
//  CircularProgressView.swift
//  NutriLog
//
//  Created by Patrick Aurel Monkam Ngaleu on 2025-11-06.
//
import SwiftUI

struct CircularProgressView: View {
    
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.green.opacity(0.5),
                    lineWidth: 30
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.red,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(Angle(degrees: -90))
                .animation(.easeOut, value: progress)
                    
        }
    }
}

