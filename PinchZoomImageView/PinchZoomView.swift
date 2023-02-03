//
//  UsageView.swift
//  PinchZoomImageView
//
//  Created by Minyoung Yoo on 2023/01/24.
//

import SwiftUI

struct PinchZoomView: View {
    @State private var currentScale : CGFloat = 1
    @State private var currentScaleFactor : CGFloat = 1
    @State private var isDragging : Bool = false
    @State private var offset : CGPoint = CGPoint(x: 0, y: 0)
    
    var pinch : some Gesture {
        MagnificationGesture()
            .onChanged { value in
                currentScaleFactor = value
            }
            .onEnded { value in
                currentScale *= value
                currentScaleFactor = 1
            }
    }
    
    var body: some View {
        //Use rect instead of image for testing.
        //let rect = Rectangle()
        let image = Image("stella")
        image.scaleEffect(currentScale * currentScaleFactor)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.offset.x += value.location.x - value.startLocation.x
                        self.offset.y += value.location.y - value.startLocation.y
                    })
            )
            .gesture(pinch)
            .offset(x: offset.x, y: offset.y)
    }
}

struct PinchZoomView2_Previews: PreviewProvider {
    static var previews: some View {
        PinchZoomView()
    }
}
