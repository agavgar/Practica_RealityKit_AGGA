//
//  ItemView.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/5/24.
//
//

import SwiftUI

struct ItemView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var items: [Item] = []

    
    var body: some View {
        ScrollView(.vertical){
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(items) { item in
                    ItemRow(itemImageURL: (item.sprites?.default)!, itemName: item.name!, itemCost: item.cost!)
                }
            }
        }
        .padding()
        .onAppear {
            DispatchQueue.main.async {
                items = homeViewModel.items
            }
        }
    }
}

#Preview {
    ItemView().environmentObject(HomeViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
