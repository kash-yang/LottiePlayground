//
//  AnimationChangeColorHelper.swift
//  LottiePlayground
//
//  Created by Kash Yang on 2023/6/16.
//

import UIKit
import Lottie

extension LottieAnimationView {
    func setAnimationWithChangeColor(name: String, color: UIColor, paths: [String]) {
        paths.forEach {
            self.setValueProvider(ColorValueProvider(color.lottieColorValue), keypath: AnimationKeypath(keypath: $0))
        }}
}
