//
//  FileManager.swift
//  SpaceOdyssey
//
//  Created by NIKOLAI BORISOV on 16.12.2021.
//

import UIKit

/// Class helps to save an image to disk 
final class FileManagerService {
    
    // MARK: - Public Methods
    
    public func saveToDisk(image: UIImage, with imageName: String) {
        let fileManager = FileManager.default
        let fileName = imageName
        guard let documentsDirectory = fileManager
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first else { return }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        // Checks if file exists, removes it if so.
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("Couldn't remove file at path", removeError)
            }
        }
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }
    
    public func loadImageFromDiskWith(name: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first {
            let imageURl = URL(fileURLWithPath: dirPath).appendingPathComponent(name)
            let image = UIImage(contentsOfFile: imageURl.path)
            return image
        }
        return nil
    }
    
}
