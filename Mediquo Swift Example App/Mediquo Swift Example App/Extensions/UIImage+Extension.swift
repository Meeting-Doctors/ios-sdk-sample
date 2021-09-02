//
//  UIImage+Extension.swift
//  Mediquo Swift Example App
//
//  Created by Xavi Roig Aznar on 2/9/21.
//  Copyright © 2021 Edgar Paz Moreno. All rights reserved.
//

import UIKit

extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func imageByMakingWhiteBackgroundTransparent() -> UIImage? {

        let image = UIImage(data: self.jpegData(compressionQuality: 1.0)!)!
        let rawImageRef: CGImage = image.cgImage!

        let colorMasking: [CGFloat] = [222, 255, 222, 255, 222, 255]
        UIGraphicsBeginImageContext(image.size);

        let maskedImageRef = rawImageRef.copy(maskingColorComponents: colorMasking)
        UIGraphicsGetCurrentContext()?.translateBy(x: 0.0,y: image.size.height)
        UIGraphicsGetCurrentContext()?.scaleBy(x: 1.0, y: -1.0)
        UIGraphicsGetCurrentContext()?.draw(maskedImageRef!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return result
    }
}
