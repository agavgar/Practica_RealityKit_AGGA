//
//  RootView.swift
//  Practica_Seguridad_AGGA
//
//  Created by Alejandro Alberto Gavira García on 23/5/24.
//

import SwiftUI
import LocalAuthentication

struct RootView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel
    @State private var isAuthenticated = false
    
    var body: some View {
        if isAuthenticated {
            HomeView().environmentObject(HomeViewModel(repository: RepositoryApiProvider(apiProvider: ApiProvider())))
        }else{
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .offset(y: -75)
                    .padding(20)
                ZStack{
                    Rectangle()
                        .fill(.white)
                        .frame(width: 260, height: 140)
                        .cornerRadius(35)
                    Rectangle()
                        .fill(.red.opacity(0.8))
                        .frame(width: 250, height: 130)
                        .cornerRadius(35)
                    Text("Please tap the pokeball button and identify yourself")
                        .frame(width: 245)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.yellow)
                        .shadow(radius: 5)
                }
                ZStack{
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 75, height: 75)
                    Circle()
                        .fill(Color.red)
                        .frame(width: 65, height: 65)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 65, height: 65)
                        .offset(y:35)
                        .clipShape(.circle)
                    Button(action: {
                        rootViewModel.authenticateUser { authenticated in
                            self.isAuthenticated = true
                        }
                    }, label: {
                        Text("Button")
                            .foregroundStyle(.clear)
                    })
                }
                .frame(width: 120, height: 120)
            }
            .offset(y: -80)
        }
    }
}

#Preview {
    RootView()
}
