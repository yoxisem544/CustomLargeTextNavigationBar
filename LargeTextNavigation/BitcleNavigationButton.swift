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

  public convenience init(image: UIImage) {
    self.init(type: .system)

    frame.size.width = buttonSize
    frame.size.height = buttonSize

    layer.cornerRadius = buttonSize / 2
    clipsToBounds = true

//    setImage(image, for: .normal)
    setBackgroundImage(image, for: .normal)
  }

  private override init(frame: CGRect) {
    super.init(frame: frame)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
