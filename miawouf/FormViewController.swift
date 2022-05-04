//
//  FormViewController.swift
//  miawouf
//
//  Created by Sébastien Delorme (Étudiant) on 2022-04-27.
//

import UIKit

extension FormViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dogRaces.count
    }
}

extension FormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension FormViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dogRaces[row]
    }
}

class FormViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear(_:)), name: UIViewController.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear(_:)), name: UIViewController.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nom(_ sender: Any) {
    }
    @IBAction func telephone(_ sender: Any) {
    }
    
    @IBOutlet weak var nomTextField: UITextField!
    
    @IBOutlet weak var telephoneTextField: UITextField!
    
    @IBOutlet weak var racePickerView: UIPickerView!
    
    @IBOutlet weak var majoritySwitch: UISwitch!
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        nomTextField.resignFirstResponder()

        telephoneTextField.resignFirstResponder()
    }
    
    
    @objc func keyboardAppear(_ notification: Notification) {
            guard let frame = notification.userInfo?[UIViewController.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            let keyboardFrame = frame.cgRectValue
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardFrame.height
            }
        }

    @objc func keyboardDisappear(_ notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func validate(_ sender: Any) {
        let pet = createPetObject()
        checkPetStatus(pet)
        

    }
    
    private func checkPetStatus(_ pet: Pet) {
        switch pet.status {
        case .accepted: performSegue(withIdentifier: "segueToSuccess", sender: pet)
        case .rejected(let reason):
            presentAlert(with: reason)
        }
    }
    
    private func presentAlert(with error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func createPetObject() -> Pet {
        let name = nomTextField.text
        let phone = telephoneTextField.text
        let hasMajority = majoritySwitch.isOn
        let gender: Pet.Gender = (genderSegmentedControl.selectedSegmentIndex == 0) ? .male : .female
        let raceIndex = racePickerView.selectedRow(inComponent: 0)
        let race = dogRaces[raceIndex]
        let dog = Pet(name: name, hasMajority: hasMajority, phone: phone, race: race, gender: gender)
        return dog
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "segueToSuccess" {
            let successVC = segue.destination as? SuccessViewController
            let pet = sender as? Pet
            successVC?.dog = pet
       }

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
