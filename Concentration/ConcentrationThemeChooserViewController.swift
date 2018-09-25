//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by minsoo kim on 2018. 9. 13..
//  Copyright © 2018년 minsoo kim. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController,UISplitViewControllerDelegate {
    
    let themes = [
        "Sports" : "⚽️🏀🏈⚾️🎱🏉🏐🎾🏓🏸🥅🏒",
        "Animals" : "🐶🐱🐭🐼🐻🦊🐰🐨🐯",
        "Faces" : "😀😃🤣😅😆☺️😇😇"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    //아래에서 secondaryViewContoller는 detail, primary는 master임.
    //false는 내가 안 했으니, 너가 해줘라는 뜻(즉 collapse가 동작함)
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController)
        -> Bool {
            if let cvc = secondaryViewController as? ConcentrationViewController {
                if cvc.theme == nil{
                    return true
                }
            }
            return false
    }

    //왜 직접 세그웨이하지 않고, 코딩으로 할까? 바로 conditional 세그웨이를 위함
    //즉 특정 상황에는 이미 있는 세그웨이한테 명령을 내리고, 없을 때에만 세그웨이를 하는 것
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
            }
        }else if let cvc = lastSeguedToConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
            
        }else{
            performSegue(withIdentifier:"Choose Theme", sender: sender)
        }
    }
    private var splitViewDetailConcentrationViewController: ConcentrationViewController?{
        
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme"{
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName]{
                    if let cvc = segue.destination as? ConcentrationViewController {
                        cvc.theme = theme
                        lastSeguedToConcentrationViewController = cvc
                    }
            }
        }
    }
}
