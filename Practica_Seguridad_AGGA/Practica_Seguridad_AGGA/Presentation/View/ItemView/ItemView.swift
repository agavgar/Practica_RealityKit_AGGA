//
//  ItemView.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/5/24.
//
//

import SwiftUI

struct ItemView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(rootViewModel.items) { item in
                    ItemRow(itemImageURL: (item.sprites?.default)!, itemName: item.name!, itemCost: item.cost!)
                }
            }
        }
        .padding()
        .onAppear {
            rootViewModel.loadItemsAPI()
        }
    }
}

#Preview {
    ItemView().environmentObject(RootViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
