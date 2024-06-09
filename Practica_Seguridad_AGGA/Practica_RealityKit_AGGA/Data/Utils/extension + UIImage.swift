//
//  extension + Image.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/5/24.
//

import UIKit

extension UIImage {
    static func loadImage(url: String) async -> UIImage? {
        if let imageURL = URL(string: url) {
            let request = URLRequest(url: imageURL)
            let (data, _) = try! await URLSession.shared.data(for: request)
            if data == data {
                return UIImage(data: data)
            }
        }
        return nil
    }
}
