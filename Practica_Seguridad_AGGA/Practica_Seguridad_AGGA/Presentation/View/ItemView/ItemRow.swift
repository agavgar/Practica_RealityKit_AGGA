//
//  ItemRow.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/5/24.
//

import SwiftUI

struct ItemRow: View {
    var itemImageURL: String
    var itemName: String
    var itemCost: Int
    @State private var itemImage: Image? = nil
    
    init(itemImageURL: String, itemName: String, itemCost: Int) {
        self.itemImageURL = itemImageURL
        self.itemName = itemName
        self.itemCost = itemCost
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 150, height: 150)
                if let itemImage = itemImage {
                    itemImage
                        .resizable()
                        .clipShape(.circle)
                        .frame(width: 150, height: 150)
                }else{
                    ProgressView()
                }
            }
            VStack{
                Text(itemName)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.red)
                Text("Cost: \(itemCost)")
                    .font(.callout)
                    .foregroundStyle(.blue)
            }
            
        }
        .onAppear {
            Task(priority: .medium) {
                itemImage = await Image(uiImage: UIImage.loadImage(url: itemImageURL)!)
            }
            
        }
    }
}

 #Preview {
 ItemRow(itemImageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/master-ball.png", itemName: "master-ball", itemCost: 9999)
 }
