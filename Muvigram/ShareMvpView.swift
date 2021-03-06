//
//  ShareMvpView.swift
//  Muvigram
//
//  Created by GangGongUi on 2017. 1. 3..
//  Copyright © 2017년 com.estsoft. All rights reserved.
//

import Foundation
import UIKit

protocol ShareMvpView: Mvpview {
    
    func playVideo(mergedVideofileUrl: URL?)
    
    func createActivityIndicatory(uiView: UIView) -> (UIActivityIndicatorView, UIView)
    
    func dimissShareViewController()
    
    func showCompleteDialog()
    
    func showShareSheet(videoUrl: URL)
    
    func enabledSaveButton(isEnabled: Bool)
}
