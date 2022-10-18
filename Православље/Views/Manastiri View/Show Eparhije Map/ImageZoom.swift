//
//  ImageZoom.swift
//  Православље
//
//  Created by VELJKO on 14.10.22..
//

import UIKit
import SwiftUI

// MARK: - Pinch Zoom
struct PinchZoomContext<Content: View>: View {
    
    var content: Content
    @State var offset: CGPoint = .zero
    @State var scale : CGFloat = 0
    @State var scalePosition: CGPoint = .zero
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .offset(x: offset.x, y: offset.y)
            .overlay {
                GeometryReader { geo in
                    let size = geo.size
                    ZoomGesture(size: size, offset: $offset, scale: $scale, scalePosition: $scalePosition)
                }
            }
            .scaleEffect(1 + scale, anchor: .init(x: scalePosition.x, y: scalePosition.y))
    }
}

// MARK: - Zoom Gesture Representable
struct ZoomGesture: UIViewRepresentable {
    
    var size: CGSize
    @Binding var offset : CGPoint
    @Binding var scale : CGFloat
    @Binding var scalePosition : CGPoint
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        // Add Pinch Gesture
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(sender:)))
        view.addGestureRecognizer(pinchGesture)
        
        // Add Pan Gesture
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(sender:)))
        panGesture.delegate = context.coordinator
        view.addGestureRecognizer(panGesture)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        
        var parent: ZoomGesture
        
        init(parent: ZoomGesture) {
            self.parent = parent
        }
        
        // MARK: - Pinch
        @objc func handlePinch(sender: UIPinchGestureRecognizer) {
            
            if sender.state == .began || sender.state == .changed {
                parent.scale = sender.scale - 1
                
                let scalePoint = CGPoint(
                    x: sender.location(in: sender.view).x / sender.view!.frame.size.width ,
                    y: sender.location(in: sender.view).y / sender.view!.frame.size.height)
                
                parent.scalePosition = (parent.scalePosition == .zero ? scalePoint : parent.scalePosition)
            }
            else {
                withAnimation(.easeInOut(duration: 0.35)) {
                    parent.scale = 0
                    parent.scalePosition = .zero
                }
            }
        }
        
        // MARK: - Pan
        @objc func handlePan(sender: UIPanGestureRecognizer) {
            
            sender.maximumNumberOfTouches = 2
            
            if (sender.state == .began || sender.state == .changed) && parent.scale > 0 {
                
                if let view = sender.view {
                    
                    let translation = sender.translation(in: view)
                    parent.offset = translation
                }
            }
            else {
                withAnimation {
                    parent.offset = .zero
                    parent.scalePosition = .zero
                }
            }
            
        }
        
        // MARK: - Gesture Methods
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }
    }
}

// MARK: - View Extenstion
extension View {
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func addPinchZoom() -> some View {
        return PinchZoomContext {
            self
        }
    }
}
