//
//  DetailTableViewController.swift
//  MyPlaces
//
//  Created by Admin on 14.07.2020.
//  Copyright © 2020 TheProdigy. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var currentPlace: Place?
    var isImageChanged: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        saveButton.isEnabled = false
        
        placeName.addTarget(self, action: #selector(textFieldNameChanged), for: .editingChanged)
        
//        Place.savePlaces()
        
        updateFields()
    }
    
    @objc func textFieldNameChanged() {
        
        saveButton.isEnabled = !placeName.text!.isEmpty
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func savePlace() {
        
        let image = isImageChanged ? placeImage.image! : #imageLiteral(resourceName: "imagePlaceholder")
        
        if currentPlace != nil {
            
            try! realm.write { 
                currentPlace?.name =        placeName.text!
                currentPlace?.location =    placeLocation.text
                currentPlace?.type =        placeType.text
                currentPlace?.image =       placeImage.image?.pngData()
            }
        } else {
            
            let place = Place(name: placeName.text!, location: placeLocation.text, type: placeType.text, image: image.pngData())
             RealmManager.save(place)
        }
        
    }
    
    func updateFields() {
        
        if currentPlace != nil {
            
            if  let topItem = navigationController?.navigationBar.topItem {
                topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            }
            navigationItem.leftBarButtonItem = nil
            
            isImageChanged = true
            title = currentPlace?.name
            saveButton.isEnabled = true
            
            placeName.text =        currentPlace?.name
            placeLocation.text =    currentPlace?.location
            placeType.text =        currentPlace?.type
            placeImage.image =      UIImage(data: (currentPlace?.image)!)
            placeImage.contentMode = .scaleAspectFill
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: "Add Photo",
                                                message: nil,
                                                preferredStyle: .actionSheet)

            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.center, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                actionSheet.dismiss(animated: true, completion: nil)
            }
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true, completion: nil)
            
        } else {
            tableView.endEditing(true)
        }
    }
    

}

extension DetailTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tableView.endEditing(true)
    }

}

extension DetailTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        
        isImageChanged = true
        
        dismiss(animated: true, completion: nil)
    }
}
