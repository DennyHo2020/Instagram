//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Denny Ho on 10/6/18.
//  Copyright © 2018 Denny Ho. All rights reserved.
//

import UIKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    var postImage: UIImage! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func onPost(_ sender: Any) {
        Post.postUserImage(image: self.postImage, withCaption: captionTextField.text) { (success: Bool , error:Error?) in
        }
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage

        shareImageView.image = editedImage
        self.postImage = editedImage

        dismiss(animated: true, completion: nil)
    }

}
