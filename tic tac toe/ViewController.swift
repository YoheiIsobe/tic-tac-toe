//
//  ViewController.swift
//  tic tac toe
//
//  Created by Nechan on 2019/07/20.
//  Copyright © 2019 Nechan. All rights reserved.
//

import UIKit
import AudioToolbox
import GoogleMobileAds

class ViewController: UIViewController{
    @IBOutlet var button: [UIButton]!
    @IBOutlet weak var judgeLabel: UILabel!
    @IBOutlet weak var playerLabel: UILabel!
    var turn = 0
    var check: [Int] = [-1,-1,-1,-1,-1,-1,-1,-1,-1]
    
    //バナー
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<9 {
            button[i].setTitle("", for: UIControl.State.normal)
            button[i].layer.borderWidth = 2.0
            button[i].layer.borderColor = UIColor.black.cgColor
        }
        judgeLabel.text = ""
        playerLabel.text = "Player: ○"
        
        //広告開始
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.rootViewController = self
        // Set the ad unit ID to your own ad unit ID here.
        bannerView.adUnitID = "ca-app-pub-4013798308034554/2995384805"
        bannerView.load(GADRequest())
    }
    
    func addBannerViewToView(_ bannerView: UIView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
            positionBannerAtBottomOfSafeArea(bannerView)
        }
        else {
            positionBannerAtBottomOfView(bannerView)
        }
    }
    
    @available (iOS 11, *)
    func positionBannerAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Centered horizontally.
        let guide: UILayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate(
            [bannerView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
             bannerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)]
        )
    }
    
    func positionBannerAtBottomOfView(_ bannerView: UIView) {
        // Center the banner horizontally.
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .centerX,
                                              multiplier: 1,
                                              constant: 0))
        // Lock the banner to the top of the bottom layout guide.
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 0))
    }

    //広告終わり------------------------------------------------------------
    
    @IBAction func pushButton(_ sender: UIButton) {
        let tag = sender.tag
        //振動
        AudioServicesPlaySystemSound(1519)
        //黒文字
        button[tag].setTitleColor(UIColor.black, for: .normal)
        //チェック
        button[tag].isEnabled = false
        if turn == 0 {
            button[tag].setTitle("○", for: UIControl.State.normal)
            check[tag] = 0
            playerLabel.text = "Player: ×"
        } else if turn == 1 {
            button[tag].setTitle("×", for: UIControl.State.normal)
            check[tag] = 1
            playerLabel.text = "Player: ○"
        }
        //ジャッジ
        judge(c: turn)
        //ターンの入れ替え
        if turn == 0 {
            turn = 1
        }else if turn == 1 {
            turn = 0
        }
    }
    
    func judge (c: Int){
        var winer :Int!
        var cnt = 0
        
        //引き分け判定
        for i in 0..<9 {
            if check[i] == -1 {
                cnt += 1
            }
        }
        //勝敗判定
        if check[0] == c && check[1] == c && check[2] == c {
            button[0].setTitleColor(UIColor.red, for: .normal)
            button[1].setTitleColor(UIColor.red, for: .normal)
            button[2].setTitleColor(UIColor.red, for: .normal)
            winer = c
        }else if check[3] == c && check[4] == c && check[5] == c {
            button[3].setTitleColor(UIColor.red, for: .normal)
            button[4].setTitleColor(UIColor.red, for: .normal)
            button[5].setTitleColor(UIColor.red, for: .normal)
            winer = c
        }else if check[6] == c && check[7] == c && check[8] == c {
            button[6].setTitleColor(UIColor.red, for: .normal)
            button[7].setTitleColor(UIColor.red, for: .normal)
            button[8].setTitleColor(UIColor.red, for: .normal)
            winer = c
        }else if check[0] == c && check[3] == c && check[6] == c {
            button[0].setTitleColor(UIColor.red, for: .normal)
            button[3].setTitleColor(UIColor.red, for: .normal)
            button[6].setTitleColor(UIColor.red, for: .normal)
            winer = c
        }else if check[1] == c && check[4] == c && check[7] == c {
            button[1].setTitleColor(UIColor.red, for: .normal)
            button[4].setTitleColor(UIColor.red, for: .normal)
            button[7].setTitleColor(UIColor.red, for: .normal)
            winer = c
        }else if check[2] == c && check[5] == c && check[8] == c {
            button[2].setTitleColor(UIColor.red, for: .normal)
            button[5].setTitleColor(UIColor.red, for: .normal)
            button[8].setTitleColor(UIColor.red, for: .normal)
            winer = c
        }else if check[0] == c && check[4] == c && check[8] == c {
            button[0].setTitleColor(UIColor.red, for: .normal)
            button[4].setTitleColor(UIColor.red, for: .normal)
            button[8].setTitleColor(UIColor.red, for: .normal)
            winer = c
        }else if check[2] == c && check[4] == c && check[6] == c {
            button[2].setTitleColor(UIColor.red, for: .normal)
            button[4].setTitleColor(UIColor.red, for: .normal)
            button[6].setTitleColor(UIColor.red, for: .normal)
            winer = c
        }else if cnt == 0{
            winer = -1
        }
        
        //勝者決定
        if winer != nil {
            if winer == 0 {
                judgeLabel.textColor = UIColor.red
                judgeLabel.text = "Winner ○"
                //音
                AudioServicesPlaySystemSound(1022)
            }else if winer == 1 {
                judgeLabel.textColor = UIColor.red
                judgeLabel.text = "Winner ×"
                //音
                AudioServicesPlaySystemSound(1022)
            }else if winer == -1 {
                judgeLabel.textColor = UIColor.black
                judgeLabel.text = "Draw"
            }

            //全てのボタン押せなくする
            for i in 0..<9 {
                button[i].isEnabled = false
            }
            playerLabel.text = "Player:  "
        }
    }

    @IBAction func resetButton(_ sender: Any) {
        for i in 0..<9 {
            button[i].isEnabled = true
            button[i].setTitle("", for: UIControl.State.normal)
            button[i].setTitleColor(UIColor.lightGray, for: .normal)
            check[i] = -1
            turn = 0
        }
        judgeLabel.text = ""
        playerLabel.text = "Player: ○"
    }
}

