//
//  MoyaTestViewController.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/21.
//  Copyright © 2020 FinupCredit. All rights reserved.
//

import Foundation

class MoyaTestViewController: BaseViewController {
    //MARK: UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.request(targetType: AppUpdateTargetType.appUpdate)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}
