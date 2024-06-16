//
//  FinalView.swift
//  Practica_RealityKit_AGGA
//
//  Created by Alejandro Gavira on 16/6/24.
//

import SwiftUI

struct FinalView: View {
    @EnvironmentObject var viewModel: PokemonViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Image("Win")
                    .ignoresSafeArea()
                .scaledToFill()
                
                Button(action: {
                    viewModel.reset()
                    NavigationLink {
                        PokemonView().environmentObject(self.viewModel)
                    } label: {
                        Text("")
                    }
                }) {
                    Text("START AGAIN")
                        .font(.title)
                        .bold()
                        .padding()
                        .border(.blue, width: 3)
                        .background(.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(10)

                }
                .padding()
            }
        }
    }
}

#Preview {
    FinalView().environmentObject(PokemonViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
}
