//
//  RankViewController.swift
//  HelloDouyu
//
//  Created by James on 2018/9/28.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class RankViewController: FCABaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "排行"
        view.backgroundColor = UIColor.randomColor()
        let button = UIButton(type: .custom)
        button.setTitle("点我", for: .normal)
        button.frame = CGRect(x: 10, y: 100, width: 100, height: 50)
        view.addSubview(button)
        button.addTarget(self, action: #selector(RankViewController.buttonDidClick), for: .touchUpInside)
    }
    
    @objc func buttonDidClick() {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.randomColor()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
