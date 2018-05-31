//
//  BitcleNavigationButton.swift
//  LargeTextNavigation
//
//  Created by David on 2018/5/31.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

final public class BitcleNavigationButton: UIButton {

  private var buttonSize: CGFloat { return 38 }

  private var redDotView: UIView!

  public private(set) var isRedDotVisible: Bool = false

  public convenience init(image: UIImage) {
    self.init(type: .system)

    frame.size.width = buttonSize
    frame.size.height = buttonSize

    layer.cornerRadius = buttonSize / 2
    clipsToBounds = true

    setBackgroundImage(image, for: .normal)

    configureRedDotView()
  }

  private override init(frame: CGRect) {
    super.init(frame: frame)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureRedDotView() {
    redDotView = UIView()
    redDotView.frame.size.width = 5
    redDotView.frame.size.height = 5

    // style
    redDotView.layer.cornerRadius = 2.5
    redDotView.backgroundColor = .red

    // position
    redDotView.frame.origin.x = 24
    redDotView.frame.origin.y = 6

    addSubview(redDotView)
    redDotView.alpha = 0
  }

  public func showRedDot(_ shouldShow: Bool) {
    let alpha: CGFloat = shouldShow ? 1 : 0
    isRedDotVisible = shouldShow
    UIView.animate(withDuration: 0.2) {
      self.redDotView.alpha = alpha
    }
  }

}
