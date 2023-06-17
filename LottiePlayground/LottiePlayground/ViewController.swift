//
//  ViewController.swift
//  LottiePlayground
//
//  Created by Kash Yang on 2023/6/16.
//

import UIKit
import Lottie
import Combine

class ViewController: UIViewController {
    
    var cancellable: AnyCancellable?
    private var animationView: LottieAnimationView!
    private var animationColor: UIColor?
    
    private let button = AdaptiveUIButton(type: .custom)
    private let picker = UIColorPickerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup button
        button.setTitle("Pick Diamond color", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(button)
        
        // setup lottie animation view
        animationView = .init(name: "animation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        self.view.addSubview(animationView)
        
        
        // add constraint
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: animationView.bottomAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: animationView.centerXAnchor).isActive = true
        
        // setup initial color of the animation and button
        if self.traitCollection.userInterfaceStyle == .dark {
            self.updateDiamondColor(.white)
            self.button.setTitleColor(.white, for: .normal)
            self.picker.selectedColor = .white
        } else {
            self.updateDiamondColor(.black)
            self.button.setTitleColor(.black, for: .normal)
            self.picker.selectedColor = .black
        }

        animationView.play()
        animationView.logHierarchyKeypaths()
    }

    @objc func buttonAction(sender: UIButton!) {
        //  Subscribing selectedColor property changes.
        self.cancellable = picker.publisher(for: \.selectedColor)
            .sink { color in
                //  Changing view color on main thread.
                DispatchQueue.main.async {
                    self.button.setTitleColor(color, for: .normal)
                    self.updateDiamondColor(color)
                    self.animationView.play()
                }
            }
        
        self.present(picker, animated: true, completion: nil)
    }
}

//MARK: - Extension
extension ViewController {
    func updateDiamondColor( _ color: UIColor) {
        self.animationView.setAnimationWithChangeColor(
            name: "animation",
            color: color,
            paths: [
                "**.Stroke 1.Color"
//                "33.Pre-comp 1.hareket Outlines *.Group 1.Stroke 1.Color",
//                "33.Pre-comp 1.hareket Outlines.Group 1.Stroke 1.Color",
//                "33.Pre-comp 1.ort Outlines.Group 1.Stroke 1.Color",
//                "33.Pre-comp 1.taban Outlines.Group *.Stroke 1.Color",
//                "prlt Outlines *.Group *.Stroke 1.Color"
            ]
        )
    }
    
}
