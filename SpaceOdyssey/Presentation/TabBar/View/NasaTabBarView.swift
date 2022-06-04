//
//  NasaTabBarView.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 12.12.2021.
//

import UIKit

/// Class provides custom view for TabBar
final class NasaTabBarView: UITabBar {
    
    // MARK: - Private Properties
    
    private var tabBarWidth: CGFloat { self.bounds.width }
    private var tabBarHeight: CGFloat { self.bounds.height }
    private var centerWidth: CGFloat { self.bounds.width / 2 }
    private let circleRadius: CGFloat = 25
    private var shapeLayer: CALayer?
    private var circleLayer: CALayer?
    
    // MARK: - Life Cycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawTabBar()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event)
        for subview in subviews {
            if pointIsInside == false {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return pointIsInside
    }
    
    // MARK: - Private Methods
    
    private func shapePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: tabBarWidth, y: 0))
        path.close()
        return path.cgPath
    }
    
    private func circlePath() -> CGPath {
        let path = UIBezierPath()
        path.addArc(
            withCenter: CGPoint(x: centerWidth, y: 12),
            radius: circleRadius,
            startAngle: 180 * .pi / 180,
            endAngle: 0 * 180 / .pi,
            clockwise: true
        )
        return path.cgPath
    }
    
    private func drawTabBar() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = shapePath()
        shapeLayer.strokeColor = UIColor.cyan.cgColor
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.lineWidth = 2.0
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath()
        circleLayer.strokeColor = UIColor.cyan.cgColor
        circleLayer.fillColor = UIColor.black.cgColor
        circleLayer.lineWidth = 2.0
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        if let oldCircleLayer = self.circleLayer {
            layer.replaceSublayer(oldCircleLayer, with: circleLayer)
        } else {
            layer.insertSublayer(circleLayer, at: 1)
        }
        self.shapeLayer = shapeLayer
        self.circleLayer = circleLayer
    }
    
}
