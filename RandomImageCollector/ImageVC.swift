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
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var item : Item? = nil
    let appDel = (UIApplication.shared.delegate as! AppDelegate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if item != nil {
            imageView.image = UIImage(data: item!.image as! Data)
            titleText.text = item!.title
            addButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }

    }

    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if item == nil {
            //add
            let item = Item(context: appDel.persistentContainer.viewContext)
            item.image = UIImagePNGRepresentation(imageView.image!)
            item.title = titleText.text
            appDel.saveContext()
        } else {
            //update
            item!.image = UIImagePNGRepresentation(imageView.image!)
            item!.title = titleText.text
            appDel.saveContext()
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func deleteTapped(_ sender: Any) {
        appDel.persistentContainer.viewContext.delete(item!)
        appDel.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
