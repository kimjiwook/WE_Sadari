//
//  IntroViewController.swift
//  Sadari
//
//  Created by kimjiwook on 2014. 12. 9..
//  Copyright (c) 2014년 KimJiWook. All rights reserved.
//

import Foundation
import UIKit

class IntroViewController:IFTTTAnimatedScrollViewController, IFTTTAnimatedScrollViewControllerDelegate {
    
    let NUMBER_OF_PAGES:Int = 3;
    var firstLabel:UILabel!
    var swipeImage:UIImageView!
//    var iconImage:UIImageView!
//    var menuImage:UIImageView!
    
    func timeForPage(page:CGFloat) -> NSInteger {
        return NSInteger(self.view.frame.size.width * (page - 1.0))
    }
    
    func inchSizeReturn() -> CGFloat {
        if self.view.frame.height > 480 {
            return 150.0
        } else {
            return 100.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.animator = IFTTTAnimator()
        
        self.scrollView.contentSize = CGSizeMake(CGFloat(NUMBER_OF_PAGES) * CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        
//        view Setting...
        self.settingViews()
        self.configureAnimation()
    }
    
    
    func settingViews() {
        // 첫번째 이미지(Swipe) (1Page)
        self.swipeImage = UIImageView(image: UIImage(named: "swipe_hand"))
        self.swipeImage.center = self.view.center
        self.swipeImage.frame = CGRectOffset(
            self.swipeImage.frame,
            CGFloat(timeForPage(1)),
            -self.inchSizeReturn())
        self.scrollView.addSubview(swipeImage)
        
        // 첫번째 레이블(인사말) (1Page)
        self.firstLabel = UILabel()
        self.firstLabel.text = "Hi!\nLet's Play"
        self.firstLabel.numberOfLines = 2
        self.firstLabel.textAlignment = NSTextAlignment.Center
        self.firstLabel.font = UIFont.systemFontOfSize(20.0)
        self.firstLabel.sizeToFit()
        self.firstLabel.center = self.view.center
        self.scrollView.addSubview(firstLabel)
        
        // (임시) 두번째 세번째
        var secondLabel:UILabel = UILabel()
        secondLabel.text = "샘플입니다. 꾸미는것은 나중에"
        secondLabel.sizeToFit()
        secondLabel.center = self.view.center
        secondLabel.frame = CGRectOffset(secondLabel.frame, CGFloat(timeForPage(2)), 0)
        self.scrollView.addSubview(secondLabel)
        
        var thirdLabel:UILabel = UILabel()
        thirdLabel.text = "시작해 볼까요"
        thirdLabel.sizeToFit()
        thirdLabel.center = self.view.center
        thirdLabel.frame = CGRectOffset(thirdLabel.frame, CGFloat(timeForPage(3)), 0)
        self.scrollView.addSubview(thirdLabel)
        
        var skipButton:UIButton = UIButton()
        skipButton.setTitle("Skip", forState: UIControlState.Normal)
        skipButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        skipButton.addTarget(self, action: "skipAction", forControlEvents: UIControlEvents.TouchUpInside)
        skipButton.sizeToFit()
        skipButton.center = self.view.center
        skipButton.frame = CGRectOffset(skipButton.frame, CGFloat(timeForPage(3)), 100)
        self.scrollView.addSubview(skipButton)
        
    }
    
    func configureAnimation() {
        // Page(1) 첫번째 레이블이동 3D 효과
        var firstTransform:IFTTTTransform3DAnimation = IFTTTTransform3DAnimation(view: self.firstLabel)
        var tt1:IFTTTTransform3D = IFTTTTransform3D(m34: 0.03)
        var tt2:IFTTTTransform3D = IFTTTTransform3D(m34: 0.3)
        tt2.rotate = IFTTTTransform3DRotate(angle: CGFloat(-M_PI), x: 1, y: 0, z: 0)
        tt2.translate = IFTTTTransform3DTranslate(tx: 0, ty: 0, tz: 50)
        tt2.scale = IFTTTTransform3DScale(sx: 1.0, sy: 2.0, sz: 1.0)
        
        firstTransform.addKeyFrames([
            IFTTTAnimationKeyFrame(time: timeForPage(0), andAlpha:1.0),
            IFTTTAnimationKeyFrame(time: timeForPage(1), andTransform3D: tt1),
            IFTTTAnimationKeyFrame(time: timeForPage(1.5), andTransform3D: tt2),
            IFTTTAnimationKeyFrame(time: timeForPage(1.5) + 1, andAlpha: 0.0),
            IFTTTAnimationKeyFrame(time: timeForPage(2), andAlpha: 0.0)
            ])
        self.animator.addAnimation(firstTransform)
        
        // Page(1) Swipe 이미지
        var swipeFrameAnimation:IFTTTFrameAnimation = IFTTTFrameAnimation(view: self.swipeImage)
        self.animator.addAnimation(swipeFrameAnimation)
        
        swipeFrameAnimation.addKeyFrame(IFTTTAnimationKeyFrame(time: timeForPage(0), andFrame: self.swipeImage.frame))
        
        var swipeAlphaAnimation:IFTTTAlphaAnimation = IFTTTAlphaAnimation(view: self.swipeImage)
        self.animator.addAnimation(swipeAlphaAnimation)
        
        swipeAlphaAnimation.addKeyFrames([
            IFTTTAnimationKeyFrame(time: timeForPage(1), andAlpha: 1.0),
            IFTTTAnimationKeyFrame(time: timeForPage(2), andAlpha: 0.0)
            ])
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    
    func skipAction(){
        // 모달뷰 처리 필요
        self.dismissViewControllerAnimated(true, completion: ({}))
    }
}