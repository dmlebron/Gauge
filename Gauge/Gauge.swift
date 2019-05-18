//
//  Gauge.swift
//  Gauge
//
//  Created by david martinez on 5/18/19.
//  Copyright © 2019 neat-labs. All rights reserved.
//
import UIKit

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let circleView = CircleView(frame: CGRect(x: 40, y: 40, width: 300, height: 150))
        circleView.backgroundColor = .clear
        let gaugeView = GaugeView(frame: CGRect(x: 40, y: 350, width: 300, height: 300))
        
        view.addSubview(circleView)
        view.addSubview(gaugeView)
        self.view = view
    }
}

class CircleView: UIView {
    typealias Degree = CGFloat
    var startAngle: Degree = 0
    var endAngle: Degree = 90
    var radiusRatio: CGFloat = 45/100
    
    override init(frame: CGRect) {
        assert(frame.width == frame.height * 2, "Width should twice the height")
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func drawLine(bottomCenterPoint: CGPoint, radius: CGFloat, context: CGContext) {
        UIColor.blue.set()
        context.move(to: bottomCenterPoint)
        context.addLine(to: pointOnCircle(radius: radius, angleInDegrees: 0, origin: bottomCenterPoint))
        context.drawPath(using: .fillStroke)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let center = CGPoint(x: rect.width / 2, y: rect.height)
        let radius = rect.width * radiusRatio
        /// dicatates the height of the inner lines
        let radiusOfInnerLines = radius * 0.90
        let bottomCenter = CGPoint(x: center.x, y: rect.height)
        
        UIColor.black.set()
        context.addArc(center: center,
                       radius: radius,
                       startAngle: startAngle.radians,
                       endAngle: endAngle.radians,
                       clockwise: true)
        context.drawPath(using: .stroke)
        
        UIColor.red.set()
        context.setLineWidth(8)
        let test4 = pointOnCircle(radius: radiusOfInnerLines, angleInDegrees: 180, origin: bottomCenter)
        context.move(to: test4)
        context.addLine(to: pointOnCircle(radius: radius, angleInDegrees: 180, origin: bottomCenter))
        context.strokePath()
        
        UIColor.green.set()
        context.setLineWidth(8)
        let test5 = pointOnCircle(radius: radiusOfInnerLines, angleInDegrees: 0, origin: bottomCenter)
        context.move(to: test5)
        context.addLine(to: pointOnCircle(radius: radius, angleInDegrees: 0, origin: bottomCenter))
        context.strokePath()
        
        UIColor.black.set()
        context.setLineWidth(2)
        let test3 = pointOnCircle(radius: radiusOfInnerLines, angleInDegrees: 45, origin: bottomCenter)
        context.move(to: test3)
        context.addLine(to: pointOnCircle(radius: radius, angleInDegrees: 45, origin: bottomCenter))
        context.strokePath()
        
        UIColor.orange.set()
        let test = pointOnCircle(radius: radiusOfInnerLines, angleInDegrees: 90, origin: bottomCenter)
        context.move(to: test)
        context.addLine(to: pointOnCircle(radius: radius, angleInDegrees: 90, origin: bottomCenter))
        context.strokePath()
        
        UIColor.magenta.set()
        let test2 = pointOnCircle(radius: radiusOfInnerLines, angleInDegrees: 135, origin: bottomCenter)
        context.move(to: test2)
        context.addLine(to: pointOnCircle(radius: radius, angleInDegrees: 135, origin: bottomCenter))
        context.strokePath()
        
        drawLine(bottomCenterPoint: bottomCenter, radius: radius * 0.95, context: context)
    }
    
    func animate() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue =
    }
    
    func pointOnCircle(radius: CGFloat, angleInDegrees: CGFloat, origin: CGPoint) -> CGPoint {
        let x = abs(CGFloat(origin.x) + radius * cos(angleInDegrees.radians))
        let y = abs(CGFloat(origin.y) - radius * sin(angleInDegrees.radians))
        
        return CGPoint(x: x, y: y)
    }
}

extension CGFloat {
    var radians: CGFloat {
        return (self * .pi) / 180
    }
}

class GaugeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        assert(frame.width == frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func draw(_ rect: CGRect) {
        drawCircle(rect)
    }
    
    func drawOval(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        let endAngle: Degree = 360
        let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        UIColor.red.setStroke()
        path.lineWidth = 13
        path.lineJoinStyle = .bevel
        path.stroke()
        path.close()
    }
    
    func drawCircle(_ rect: CGRect) {
        let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        let startAngle: Degree = -45
        let endAngle: Degree = -135
        let path = UIBezierPath(arcCenter: center,
                                radius: frame.width * 0.45,
                                startAngle: startAngle.radians,
                                endAngle: endAngle.radians,
                                clockwise: false)
        UIColor.red.setStroke()
        path.lineWidth = 5
        path.stroke()
        //        path.close()
        
        //        let path2 = UIBezierPath(arcCenter: center,
        //                                radius: frame.width * 0.45,
        //                                startAngle: 0,
        //                                endAngle: endAngle.radians,
        //                                clockwise: false)
        //        path2.setLineDash([1, (frame.width * 0.45)], count: 2, phase: 0)
        //        UIColor.orange.setStroke()
        //        path2.lineWidth = 10
        //        path2.stroke()
        //        path.fill()
        //        path2.close()
    }
}

typealias Degree = CGFloat
//

//class GaugeView: UIView {
//    var outerBezelColor = UIColor(red: 0, green: 0.5, blue: 1, alpha: 1)
//    var outerBezelWidth: CGFloat = 10
//    var innerBezelColor = UIColor.white
//    var innerBezelWidth: CGFloat = 5
//    var insideColor = UIColor.white
//
//    var totalAngle: CGFloat = 180
//    var rotation: CGFloat = 0
//
//    var segmentWidth: CGFloat = 10
//    var numberOfSegments = 4
////    var segmentColors = [UIColor(red: 0.7, green: 0, blue: 0, alpha: 1),
////                         UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
////                         UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
////                         UIColor(red: 0, green: 0.5, blue: 0, alpha: 1),
////                         UIColor(red: 0.7, green: 0, blue: 0, alpha: 1)]
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        drawBackground(in: rect, context: context)
//        drawSegments(in: rect, context: context)
//    }
//
//    func drawBackground(in rect: CGRect, context context: CGContext) {
//        // draw the outer bezel as the largest circle
//        outerBezelColor.set()
//        context.fillEllipse(in: rect)
//
//        // move in a little on each edge, then draw the inner bezel
//        let innerBezelRect = rect.insetBy(dx: outerBezelWidth, dy: outerBezelWidth)
//        innerBezelColor.set()
//        context.fillEllipse(in: innerBezelRect)
//
//        // finally, move in some more and draw the inside of our gauge
//        let insideRect = innerBezelRect.insetBy(dx: innerBezelWidth, dy: innerBezelWidth)
////        insideColor.set()
//        context.fillEllipse(in: insideRect)
//    }
//
//    func deg2rad(_ number: CGFloat) -> CGFloat {
//        return number * .pi / 180
//    }
//
//    func drawSegments(in rect: CGRect, context: CGContext) {
//        // 1: Save the current drawing configuration
//        context.saveGState()
//
//        // 2: Move to the center of our drawing rectangle and rotate so that we're pointing at the start of the first segment
//        context.translateBy(x: rect.midX, y: rect.midY)
////        context.rotate(by: .pi/2)
//
//        // 3: Set up the user's line width
//        context.setLineWidth(segmentWidth)
//
//        // 4: Calculate the size of each segment in the total gauge
//        let segmentAngle = deg2rad(totalAngle)
//
//        // 5: Calculate how wide the segment arcs should be
//        let radius = (((rect.width  - segmentWidth) / 2) - outerBezelWidth) - innerBezelWidth
//        print(radius)
//
//        UIColor.red.set()
//        //            segment.set()
//
//        // add a path for the segment
//        context.addArc(center: .zero, radius: radius, startAngle: 0, endAngle: .pi, clockwise: true)
//
//        // and stroke it using the activated color
//        context.drawPath(using: .stroke)
//
//        // 6: Draw each segment
////        for index in 0...numberOfSegments {
////            // figure out where the segment starts in our arc
////            let start = CGFloat(index) * segmentAngle
////            print(start)
////            // activate its color
////            UIColor.red.set()
//////            segment.set()
////
////            // add a path for the segment
////            context.addArc(center: .zero, radius: segmentRadius, startAngle: start, endAngle: start + segmentAngle, clockwise: false)
////
////            // and stroke it using the activated color
////            context.drawPath(using: .stroke)
////        }
//
//        // 7: Reset the graphics state
//        context.restoreGState()
//    }
//}
