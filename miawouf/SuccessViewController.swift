//
//  SuccessViewController.swift
//  miawouf
//
//  Created by Sébastien Delorme (Étudiant) on 2022-04-27.
//

import UIKit

class SuccessViewController: UIViewController {
    
    var dog: Pet?
    @IBOutlet weak var successViewText: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let desc = dog else {
            return
        }
        guard let name = desc.name else{
            return
        }
        let messageSuccess = """
        Woof de Bienvenu a
        \(name)
        Vous avez bien ete ajouter a notre base de donnee. Nous vous enverrons un SMS !!!
        """
        successViewText.text = messageSuccess
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
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
