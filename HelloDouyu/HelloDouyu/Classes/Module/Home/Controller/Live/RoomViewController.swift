//
//  RoomViewController.swift
//  HelloDouyu
//
//  Created by James on 2019/1/24.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

class RoomViewController: FCABaseViewController {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nikenameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    
    
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
}
// MARK:- private method
extension RoomViewController {
    private func setupUI() {
//        view.backgroundColor = UIColor.randomColor()
        setupBlurView()
    }
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        bgImageView.addSubview(blurView)
        blurView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self.bgImageView)
        }
    }
    private func execEmitter() {
//        let emitterLayer = CAEmitterLayer()
//        emitterLayer.scale = 1
        let starsView = StarsEmitterView(frame: view.bounds)
//        starsView.frame = CGRect(x: 0, y: 0, width: view.ct_width(), height: view.ct_height())
        view.addSubview(starsView)
//        starsView.snp.makeConstraints { (make) in
//            make.left.top.right.bottom.equalTo(self.view)
//        }
    }
}
// MARK:- Button Action
extension RoomViewController {
    @IBAction func closeBtnDidClick(_ sender: UIButton) {
        back()
    }
    @IBAction func audienceBtnDidClick(_ sender: UIButton) {
        print("点击了观众")
    }
    @IBAction func attentionBtnDidClick(_ sender: UIButton) {
        print("点击了关注")
    }
    @IBAction func chatBtnDidClick(_ sender: UIButton) {
        print("点击了聊天")
    }
    @IBAction func shareBtnDidClick(_ sender: UIButton) {
        print("点击了分享")
    }
    @IBAction func giftBtnDidClick(_ sender: UIButton) {
        print("点击了礼物")
    }
    @IBAction func moreBtnDidClick(_ sender: UIButton) {
        print("点击了更多")
    }
    @IBAction func starsBtnDidClick(_ sender: UIButton) {
        print("点击了星星")
        execEmitter()
    }
}
