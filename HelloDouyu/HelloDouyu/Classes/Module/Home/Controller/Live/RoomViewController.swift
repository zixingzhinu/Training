//
//  RoomViewController.swift
//  HelloDouyu
//
//  Created by James on 2019/1/24.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

class RoomViewController: FCABaseViewController {

    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
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
