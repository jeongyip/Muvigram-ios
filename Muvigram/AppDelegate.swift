//
//  AppDelegate.swift
//  Muvigram
//
//  Created by GangGongUi on 2016. 11. 30..
//  Copyright © 2016년 com.estsoft. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container: Container = Container() { container in
        container.register(MusicService.self) { _ in MusicService()}
        container.register(VideoService.self) {_ in VideoService()}
        
        container.register(DataManager.self) { r in
            DataManager(musicService: r.resolve(MusicService.self)!, videoService: r.resolve(VideoService.self)!)
            }.inObjectScope(.container)
        
        container.register(MusicPresenter.self) {r in
            MusicPresenter<MusicViewController>(dataManager: r.resolve(DataManager.self)!)
        }
        
        container.register(CameraPresenter.self) { r in
            CameraPresenter<CameraViewController>(dataManager: r.resolve(DataManager.self)!)
        }
        
        // Views
        container.registerForStoryboard(MusicViewController.self) { r, c in
            let presenter = r.resolve(MusicPresenter<MusicViewController>.self)!
            presenter.attachView(view: c)
            c.presenter = presenter
        }
        container.registerForStoryboard(CameraViewController.self) { r, c in
            let presenter = r.resolve(CameraPresenter<CameraViewController>.self)!
            presenter.attachView(view: c)
            c.presenter = presenter
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        self.window = window
        let bundle = Bundle(for: LaunchViewController.self)
        let storyBoard = SwinjectStoryboard.create(name: "Main", bundle: bundle, container: container)
        
        container.registerForStoryboard(MainPageViewController.self) { r, c in
            c.orderedViewControllers = [storyBoard.instantiateViewController(withIdentifier: "MusicViewController"),
                                        storyBoard.instantiateViewController(withIdentifier: "CameraViewController")]
        }
        
        container.registerForStoryboard(LaunchViewController.self) { r, c in
            c.mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
        }
        
        window.rootViewController = storyBoard.instantiateInitialViewController()
        return true
    }
}

