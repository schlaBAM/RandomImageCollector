//
//  ImageVC.swift
//  RandomImageCollector
//
//  Created by BAM on 2017-09-28.
//  Copyright © 2017 BAM. All rights reserved.
//

import UIKit

class ImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UITextField!
    
    var imagePicker = UIImagePickerController()
    let appDel = (UIApplication.shared.delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

    }

    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let item = Item(context: appDel.persistentContainer.viewContext)
        item.image = UIImagePNGRepresentation(imageView.image!)
        item.title = titleText.text
        appDel.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
