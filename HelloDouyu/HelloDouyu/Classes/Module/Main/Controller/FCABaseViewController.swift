//
//  FCABaseViewController.swift
//  HelloDouyu
//
//  Created by James on 2018/9/28.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class FCABaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    

}

extension FCABaseViewController {
    func back() {
        if (self.presentingViewController != nil) {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
