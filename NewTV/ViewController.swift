//
//  ViewController.swift
//  NewTV
//
//  Created by Hanawa Takuro on 2017/06/19.
//  Copyright © 2017年 Hanawa Takuro. All rights reserved.
//

import UIKit

class NewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    override func soundIdentifierForFocusUpdate(
        in context: UIFocusUpdateContext) -> UIFocusSoundIdentifier? {

        return UIFocusSoundIdentifier(rawValue: "newSounds")
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter = NotificationCenter.default

        notificationCenter.addObserver(
            self, selector: #selector(focusDidUpdate), name: .UIFocusDidUpdate, object: nil)

        notificationCenter.addObserver(
            self, selector: #selector(focusDidUpdate), name: .UIFocusMovementDidFail, object: nil)

        // func contains(_ environment: UIFocusEnvironment) -> Bool
        // print("View " + (view.contains(button) ? "contains Button 🙆" : "does't contains Button 🙅"))
    }

    @objc func focusDidUpdate() {

        // var isFocused: Bool { get }
        // print("Button is " + (button.isFocused ? "Focused 😀" : "not Focused 😭"))

        // static let UIFocusDidUpdate: NSNotification.Name
        // print("Focus Did Update ⭐️")
    }

    @objc func focusMovementDidFail() {

        // static let UIFocusMovementDidFail: NSNotification.Name
        // print("Focus Movement Did Fail 💀")
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {

        return 20
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "newCell", for: indexPath) as! NewCell

        cell.imageView.image = #imageLiteral(resourceName: "sowhat")
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
        with coordinator: UIFocusAnimationCoordinator) {

        // func addCoordinatedFocusingAnimations(_ animations: ((UIFocusAnimationContext) -> Void)?, completion: (() -> Void)? = nil)
        if let indexPath = context.nextFocusedIndexPath {

            let cell = collectionView.cellForItem(at: indexPath) as? NewCell
            coordinator.addCoordinatedFocusingAnimations({ animationContext in

                cell?.imageView.transform = CGAffineTransform(rotationAngle: 90.0)

            })
        }

        // func addCoordinatedUnfocusingAnimations(_ animations: ((UIFocusAnimationContext) -> Void)?, completion: (() -> Void)? = nil)
        if let indexPath = context.previouslyFocusedIndexPath {

            let cell = collectionView.cellForItem(at: indexPath) as? NewCell
            coordinator.addCoordinatedUnfocusingAnimations({ animationContext in

                cell?.imageView.transform = .identity

            })
        }

//        // Before: addCoordinatedAnimations
//        coordinator.addCoordinatedAnimations({
//            if let indexPath = context.nextFocusedIndexPath {
//
//                let cell = collectionView.cellForItem(at: indexPath) as? NewCell
//                cell?.imageView.transform = CGAffineTransform(rotationAngle: 90.0)
//            }
//
//            if let indexPath = context.previouslyFocusedIndexPath {
//
//                let cell = collectionView.cellForItem(at: indexPath) as? NewCell
//                cell?.imageView.transform = .identity
//            }
//        })
    }
}

// (lldb) po UIFocusDebugger.help()
//
// Focus Debugging Utilities:
//
// Status:
// Swift: po UIFocusDebugger.status()
// ObjC:  po [UIFocusDebugger status]
//
// Overview:
// Outputs information for the currently focused item.
//
// Diagnosing Focusability Issues:
// Swift: po UIFocusDebugger.checkFocusability(for: <item reference>)
// ObjC:  po [UIFocusDebugger checkFocusabilityForItem:<item reference>]
//
// Overview:
// Outputs a diagnosis of the specified item's focusability, including any known issues that may be preventing focusability.
//
// Simulating Focus Updates:
// Swift: po UIFocusDebugger.simulateFocusUpdateRequest(from: <environment reference>)
// ObjC:  po [UIFocusDebugger simulateFocusUpdateRequestFromEnvironment:<environment reference>]
//
// Overview:
// Simulates a fake focus update requested by the specified environment (e.g. `[environment setNeedsFocusUpdate]`), outlining each step of the process for determining the next focused item.

