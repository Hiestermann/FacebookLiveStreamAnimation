//
//  ViewController.swift
//  FacebookLiveStreamAnimation
//
//  Created by Kilian on 20.12.17.
//  Copyright © 2017 Kilian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let curvedView = CurvedView(frame: view.frame)
//        curvedView.backgroundColor = .yellow
        
//        view.addSubview(curvedView)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTab)))
    }
    
    @objc func handleTab() {
        (0...10).forEach {(_) in generateAnimatedViews()}
    }
    
    fileprivate func generateAnimatedViews(){
        let image = drand48() > 0.5 ? #imageLiteral(resourceName: "free-badge-256-2") : #imageLiteral(resourceName: "favorite-7-256-2")
        let imageView = UIImageView(image: image)
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: 30)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = costomPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
    }

}

func costomPath() -> UIBezierPath {
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x: 0, y: 200))
    
    let endPoint = CGPoint(x: 600, y: 200)
    
    let randomYShift = 2 * drand48() * 300
    
    let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView: UIView {
    override func draw(_ rect: CGRect) {
        
        let path = costomPath()
        path.lineWidth = 3
        path.stroke()
    }
}
