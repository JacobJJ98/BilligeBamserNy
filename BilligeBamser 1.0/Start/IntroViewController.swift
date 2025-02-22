//
//  IntroViewController.swift
//  BilligeBamser 1.0
//
//  Created by Jacob Jørgensen on 18/10/2019.
//  Copyright © 2019 Jacob Jørgensen. All rights reserved.
//

import UIKit
import Hero

class IntroViewController: UIViewController, UITabBarControllerDelegate {
    
    let tabbarController = TabbarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FirebaseAPI.shared.nuvaerendeBruger() != nil {
            FirebaseAPI.shared.hentBruger { (bruger, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    if let brugeren = bruger {
                        BarListe.shared.tilføjBruger(bruger: brugeren)
                    }
                    FirebaseAPI.shared.hentBarer { (result, error) in
                        if error != nil {
                            print(error!.localizedDescription)
                        } else {
                            if let barene = result {
                                for bar in barene {
                                    BarListe.shared.addBar(bar: bar)
                                }
                                BarListe.shared.findFavo()
                                
                                self.present(self.tabbarController, animated: false, completion: nil)
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        } else {
            print("IKKE LOGGET IND!!")
            self.performSegue(withIdentifier: "forNewUser", sender: nil)
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
