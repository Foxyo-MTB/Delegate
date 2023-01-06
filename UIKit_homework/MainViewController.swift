//
//  MainViewController.swift
//  UIKit_homework
//
//  Created by Vladimir Beliakov on 13.09.2022.
//

import UIKit

protocol MainViewControllerDelegate {
    
    func getSettings(_ settings: UIColor)
    
}

class MainViewController: UIViewController, MainViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewControllerVC = segue.destination as! ViewController
        viewControllerVC.colorDefault = view.backgroundColor
        viewControllerVC.delegate = self
    }
    
    func getSettings(_ settings: UIColor) {
        view.backgroundColor = settings
    }

}
