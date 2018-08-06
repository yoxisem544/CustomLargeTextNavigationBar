//
//  LargeTextNavigationBar.swift
//  LargeTextNavigation
//
//  Created by David on 2018/5/30.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

final public class LargeTextNavigationBar: UIView {

  // MARK: - Properties

  /// floatingTitleBarHeight is used for large text extra height
  ///
  /// iPhone X:
  ///  - standard height 88pt
  ///  - large text height 140pt
  ///
  /// Other iPhone:
  ///  - standard height 64pt
  ///  - large text height 116pt
  ///
  /// (large - standard) is **52pt**
  private var floatingTitleBarHeight: CGFloat {
    return 52.0
  }

  private var floatingBarHeight: CGFloat {
    return floatingTitleBarHeight
  }

  /// This Nav Bar's max height
  public var maxHeight: CGFloat {
    return floatingTitleBarHeight + statusBarHeight + staticBarHeight
  }

  /// use for trigger animation for show and hide of static bar title label
  ///
  /// - positive for earier show
  ///
  /// - negative for delay show
  private var staticBarAnimatingOffsetDelta: CGFloat {
    return 7.0
  }

  /// determine status bar's height wether its iPhone X or other device
  ///
  /// iPhone X's status bar height is 44.
  /// Other devices' are 20
  private var statusBarHeight: CGFloat {
    return UIDevice.type == .iPhoneX ? 44 : 20
  }

  /// static bar's height
  let staticBarHeight: CGFloat = 44.0

  // MARK: - Subviews
  private var staticBarView: UIView!
  private var staticBarTitleLabel: UILabel!

  private var floatingBarView: UIView!
  private var floatingBarTitleLabel: UILabel!

  private var newPostButton: BitcleNavigationButton!
  private var notificationButton: BitcleNavigationButton!
  private var moreContentButton: BitcleNavigationButton!



  // MARK: - Init
  public convenience init() {
    self.init(frame: CGRect.zero)

    frame.size.width = UIScreen.main.bounds.width
    backgroundColor = .white

    configureStaticBarView()

    configureFloatingBarView()

  }

  private override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configuration
  private func configureStaticBarView() {
    staticBarView = UIView()
    staticBarView.frame.size.width = bounds.width
    staticBarView.frame.size.height = staticBarHeight + statusBarHeight

    // style
    staticBarView.backgroundColor = .white

    addSubview(staticBarView)

    // subview
    configureStaticBarTitleLabel()
  }

  private func configureStaticBarTitleLabel() {
    let fontSize: CGFloat = 18
    staticBarTitleLabel = UILabel()
    staticBarTitleLabel.frame.size.height = fontSize
    staticBarTitleLabel.frame.size.width = staticBarView.bounds.width

    // style
    staticBarTitleLabel.textColor = .black
    staticBarTitleLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
    staticBarTitleLabel.textAlignment = .center
    staticBarTitleLabel.text = "社群動態"
    
    staticBarTitleLabel.center.y = statusBarHeight + staticBarHeight / 2
    staticBarView.addSubview(staticBarTitleLabel)
  }

  private func configureFloatingBarView() {
    floatingBarView = UIView()
    floatingBarView.frame.size.width = staticBarView.bounds.width
    floatingBarView.frame.size.height = floatingTitleBarHeight

    // style
    floatingBarView.backgroundColor = .white

    floatingBarView.frame.origin.y = staticBarView.bounds.height
    insertSubview(floatingBarView, belowSubview: staticBarView)

    // subviews
    configureFloatingBarTitleLabel()
    configureNewPostButton()
    configureNotificationButton()
    configureMoreContentButton()
  }

  private func configureFloatingBarTitleLabel() {
    let leftMargin: CGFloat = 20
    let fontSize: CGFloat = 34
    floatingBarTitleLabel = UILabel()
    floatingBarTitleLabel.frame.size.width = floatingBarView.bounds.width - 2 * leftMargin
    floatingBarTitleLabel.frame.size.height = fontSize

    // style
    floatingBarTitleLabel.textColor = .black
    floatingBarTitleLabel.text = "社群動態"
    floatingBarTitleLabel.font = UIFont(name: ".SFUIDisplay-Bold", size: fontSize)
    floatingBarTitleLabel.sizeToFit()

    // position
    floatingBarTitleLabel.center.y = floatingBarView.bounds.height / 2
    floatingBarTitleLabel.frame.origin.x = leftMargin
    floatingBarView.addSubview(floatingBarTitleLabel)
  }

  private func configureNewPostButton() {
    let rightMargin: CGFloat = 22
    newPostButton = BitcleNavigationButton(image: #imageLiteral(resourceName: "RoundNewpostIcon"))

    // position
    newPostButton.frame.origin.x = floatingBarView.bounds.width - newPostButton.bounds.width - rightMargin
    newPostButton.center.y = floatingBarTitleLabel.center.y
    floatingBarView.addSubview(newPostButton)

    newPostButton.action = { [unowned self] in
      self.newPostButton.showRedDot(!self.newPostButton.isRedDotVisible)
    }
  }

  private func configureNotificationButton() {
    let margin: CGFloat = 13
    notificationButton = BitcleNavigationButton(image: #imageLiteral(resourceName: "RoundBellIcon"))

    // position
    notificationButton.frame.origin.x = newPostButton.frame.origin.x - notificationButton.bounds.width - margin
    notificationButton.center.y = newPostButton.center.y
    floatingBarView.addSubview(notificationButton)

    notificationButton.action = { [unowned self] in
      self.notificationButton.showRedDot(!self.notificationButton.isRedDotVisible)
    }
  }

  private func configureMoreContentButton() {
    let margin: CGFloat = 13
    moreContentButton = BitcleNavigationButton(image: #imageLiteral(resourceName: "RoundArrowIcon"))

    // position
    moreContentButton.frame.origin.x = notificationButton.frame.origin.x - moreContentButton.bounds.width - margin
    moreContentButton.center.y = notificationButton.center.y
    floatingBarView.addSubview(moreContentButton)

    moreContentButton.action = { [unowned self] in
      self.moreContentButton.showRedDot(!self.moreContentButton.isRedDotVisible)
    }
  }

  // MARK: - Update Bar Private Methods

  private func hideStaticTitleLabel(animated: Bool = true) {
    animateStaticTitleLabel(alpha: 0.0, animated: animated)
  }

  private func showStaticTitleLabel(animated: Bool = true) {
    animateStaticTitleLabel(alpha: 1.0, animated: animated)
  }

  private func animateStaticTitleLabel(alpha: CGFloat, animated: Bool) {
    UIView.animate(
      withDuration: 0.15,
      delay: 0,
      options: [],
      animations: {
        self.staticBarTitleLabel.alpha = alpha
      },
      completion: nil)
  }

  private func moveFloatingBar(with offsetY: CGFloat) {
    let barY = -(offsetY + maxHeight) // set offset to 0, for ease to deal with offset
    if barY >= 0 {
      // user pulling down
      let growingheight = 25 * atan(barY/60)
      floatingBarView.frame.origin.y = staticBarView.bounds.height + growingheight
    } else {
      // user pushing up, floating bar goes up
      let newY = barY + staticBarView.bounds.height
      let yThatCanHideFloatingBar = staticBarView.bounds.height - floatingBarHeight
      if newY < yThatCanHideFloatingBar {
        // means floating bar is moving too far
        floatingBarView.frame.origin.y = yThatCanHideFloatingBar
      } else {
        floatingBarView.frame.origin.y = newY
      }
    }
    // expand self.view's frame
    frame.size.height = floatingBarView.frame.maxY
  }

  // MARK: - Public Method to update Nav Bar

  /// adjust view's arrangement with content offset
  ///
  /// - Parameter offset: scroll view's content offset
  public func updateBar(with scrollView: UIScrollView) {
    if scrollView.contentOffset.y > (0 - scrollView.contentInset.top + floatingTitleBarHeight - staticBarAnimatingOffsetDelta) {
      // scrolling up for more content
      showStaticTitleLabel()
    } else {
      // scrolling down and reach top, no more content
      hideStaticTitleLabel()
    }
    moveFloatingBar(with: scrollView.contentOffset.y)
  }

  public func endDraggingWithoutDecelerate(_ scrollView: UIScrollView) {
    let barY = -(scrollView.contentOffset.y + maxHeight)
    if barY < -(floatingBarHeight / 2) {
      // push up, need to hide floating view
      UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
        scrollView.contentOffset.y = (self.floatingBarHeight - scrollView.contentInset.top)
      }, completion: nil)
    } else {
      UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
        scrollView.contentOffset.y = -scrollView.contentInset.top
      }, completion: nil)
    }
  }

  @objc private func toggleRedDot(button: BitcleNavigationButton) {
    button.showRedDot(!button.isRedDotVisible)
  }

}
