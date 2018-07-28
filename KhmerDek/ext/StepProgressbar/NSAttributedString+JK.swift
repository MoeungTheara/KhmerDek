//
//  NSAttributedString+JK.swift
//  JKSteppedProgressBar
//
//  Created by Jayahari Vavachan on 6/12/18.
//

import UIKit

extension NSAttributedString {
    func draw(center: CGPoint,widthTitle:CGFloat) {
        
        let drawingOptions: NSStringDrawingOptions = [
            .usesLineFragmentOrigin, .usesFontLeading]
        let rectInOneLine = self.boundingRect(with: CGSize(width: 1000, height: 1000), options: drawingOptions, context: nil)
        let heigthOneLine = rectInOneLine.size.height
        //
        var rect = self.boundingRect(with: CGSize(width: widthTitle, height: 1000), options: drawingOptions, context: nil)
        let size = rect.size
        let origin = CGPoint(x: center.x - size.width / 2.0, y: center.y - heigthOneLine / 2.0)
        rect.origin = origin
        self.draw(with: rect, options: drawingOptions, context: nil)
    }
}
