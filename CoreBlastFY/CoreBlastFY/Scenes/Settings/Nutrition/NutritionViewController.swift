//
//  NutritionViewController.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/24/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class NutritonViewController: UIViewController, UICollisionBehaviorDelegate {
    
    //TO DO: - Refactor
    let data = ["Nutriton Guidelines", "What to Avoid!", "Sample Meal Ideas", "Rest & Recovery"]
    let nutritionData = ["What you eat is the 1st and most important part of this program. Over the 12 weeks we will build great habits that will enable your success for continual improvement. With that in mind, you have lots of options as long as you think in types. Proteins, Veggies, Fruits, Complex Carbs. Proteins can include, eggs, chicken, fish, steak, tofu, and ground beef. With veggies, take your pick and eat lots of them, examples are kale, spinach, broccoli, avocados, peppers, zuchini, and cucumbers. Fruits are great for snacks and smoothies, all types of berries, bananas, apples. When making smoothies with fruit with extra sugar like mangos or pineapple make sure half of the contents is a green superfood for slower absorption. Complex carbs are great fillers which include, brown rice, quinoa, old fashined oatmeal, lentils, beans, and sweet potatoes. Snacks are good for nuts, seeds and more fruits and veggies.",
                         "What to avoid is just as important to efficiently get to your goals! Think again in types, which are sugars, flours, fatty fried foods. So all the processed junk has to go : candy, fastfood, alcohol, bread, tortillas, chips, soda, dairy.",
                         "Here is a sample of meal ideas to help you if have no clue how to structure meals. \nBreakfast: Smoothie with kale, banana, berries, almond milk. \nSnack : almonds and apple or cucumbers. \nLunch: Salad with tuna and eggs or your favortie protein. \nDinner: Roasted chicken, with favorite veggie and brown rice.",
                         "To be successful you have to plan ahead or you will fail! \nNumber 1: meal prep for at least a couple of days at a time, having great food ready to eat is a major key to staying on track. \nNumber 2: drink lots of water, have to stay hydrated. \nNumber 3: make sure to get good sleep every night, your body will thank you. Minimum 7 hours. \nNumber 4: Remember why you started this, and ask how bad do you want it. You have to be discipline, and focused on the end result and be consistent. You're planting a seed, and can't expect the tree to grow overnight. Put in the work and don't cheat yourself and results will come. Last tip: It's ok to mess up, get back up and keep focused, we're human. Were creating a Lifetsyle of good choices in a lot of aspects here so the good will outweigh the bad. Take it one day at a time! Have fun!"
    ]
    
    var views = [UIView]()
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var snap: UISnapBehavior!
    var previousTouchPoint:CGPoint!
    var viewDragging = false
    var viewPinned = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupImageView()
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()

        animator.addBehavior(gravity)
        gravity.magnitude = 4
        
        var offset:CGFloat = 300
        
        for i in 0 ... data.count - 1 {
            if let view = addViewController(atOffset: offset, dataForVC: data[i], nutritionData: nutritionData[i]) {
                views.append(view)
                offset -= 50
            }
        }
    }
    
    func addViewController(atOffset offset:CGFloat, dataForVC data: String?, nutritionData: String?) -> UIView? {
        
        let frameForView = self.view.bounds.offsetBy(dx: 0, dy: self.view.bounds.size.height - offset)
        
        let stackElementVC = StackElementViewController()
    
        if let view = stackElementVC.view {
            view.frame = frameForView
            view.layer.cornerRadius = 5
            view.layer.shadowOffset = CGSize(width: 2, height: 2)
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowRadius = 3
            view.layer.shadowOpacity = 0.5
            
            
            if let headerStr = data, let nutritionStr = nutritionData {
                stackElementVC.headerString = headerStr
                stackElementVC.bodyString = nutritionStr
            }
            
            
            self.addChild(stackElementVC)
            self.view.addSubview(view)
            stackElementVC.didMove(toParent: self)
            
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(tapGesture:)))
            view.addGestureRecognizer(tapGesture)
            
            return view
            
            
        }
        
        return nil
        
        
    }
    
    @objc func handleTap(tapGesture: UITapGestureRecognizer) {
        let tappedView = tapGesture.view!
        switch tapGesture.state {
        case .ended :
            if viewDragging {
                UIView.animate(withDuration: 0.2,
                               delay: 0.05,
                               options: .curveEaseOut,
                               animations: {
                                tappedView.transform = .identity
                    }, completion: nil)
                viewDragging = false
            } else {
                UIView.animate(withDuration: 0.2,
                               delay: 0.05,
                               options: .curveEaseIn,
                               animations: { [weak view] in
                                guard let view = view else { return }
                                tappedView.transform = CGAffineTransform(translationX: 0, y: -(view.frame.height * 0.6))
                }, completion: nil)
                
                viewDragging = true
            }
        default: break
        }
    }
    
    //MARK: - Methods
    
    private func setupImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    //MARK: - Properties
    
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "nutrition")
        return imageView
    }()
}
