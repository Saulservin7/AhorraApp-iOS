//
//  ProfileView.swift
//  AhorrApp
//
//  Created by Saul Servin on 17/06/25.
//

import SwiftUI


@available(iOS 17.0, *)
struct ProfileView : View{
    
    @StateObject var viewModel : ProfileViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var editMode: Bool = false
    
    var onProfileUpdate: (() -> Void)?
    
    var body: some View {
        NavigationView{
            VStack(spacing : 20){
                switch viewModel.state {
                case .loading:
                    ProgressView("Cargando Perfil")
                case .success(let user):
                    VStack(spacing: 12) {
                        let isProfileComplete = (user.name?.isEmpty == false) && (user.photoURL != nil)

                        // Show warning only if incomplete and not in edit mode
                        if !isProfileComplete && !editMode {
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.orange)
                                Text("Te falta completar tu perfil (nombre o foto)").foregroundColor(.orange)
                                Spacer()
                                Button("Completar perfil") { editMode = true }
                            }
                            .padding(8)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(10)
                        }

                        if editMode {
                            TextField("Nombre", text: $viewModel.currentUserName)
                                .padding(8)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)

                            if let image = viewModel.profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .padding(.bottom, 8)
                            } else if let url = user.photoURL {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty: ProgressView()
                                    case .success(let img): img.resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80).clipShape(Circle())
                                    default: Image(systemName: "person.crop.circle.fill").resizable().frame(width: 80, height: 80).foregroundColor(.gray)
                                    }
                                }.padding(.bottom, 8)
                            } else {
                                Image(systemName: "person.crop.circle.badge.plus")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 8)
                            }
                            Button("Seleccionar foto") {
                                viewModel.showImagePicker = true
                            }
                            .padding(.bottom, 8)

                            Button("Guardar") {
                                Task {
                                    await viewModel.updateProfile()
                                    await viewModel.fetchCurrentUser()
                                    editMode = false
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        } else {
                            // Show user photo from URL, fallback to system icon
                            if let url = user.photoURL {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty: ProgressView()
                                    case .success(let img): img.resizable().aspectRatio(contentMode: .fill).frame(width: 80, height: 80).clipShape(Circle())
                                    default: Image(systemName: "person.crop.circle.fill").resizable().frame(width: 80, height: 80).foregroundColor(.gray)
                                    }
                                }
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.gray)
                            }
                            Text(user.name ?? "Sin nombre")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            if isProfileComplete {
                                Button("Editar") { editMode = true }
                                    .buttonStyle(.bordered)
                            }
                        }
                    }
                case .error(let message):
                    Image(systemName: "exclamationmark.triangle.fill")
                                           .font(.system(size: 50))
                                           .foregroundColor(.red)
                                       Text(message)
                                           .foregroundColor(.red)
                                           .multilineTextAlignment(.center)
                                           .padding()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Perfil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("Cerrar") {
                                        dismiss() // Llama a la acción de SwiftUI para cerrar la vista.
                                    }
                                }
            }
        }.onChange(of: viewModel.updateSucceded){
            success in
            if success {
                onProfileUpdate?()
                dismiss()
            }
        }
            .onAppear{
            Task{
                await viewModel.fetchCurrentUser()
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            // Elige aquí el Picker que usas (ejemplo estándar):
             ImagePicker(image: $viewModel.profileImage, onImagePicked: { image in
                 viewModel.didSelectImage(image)
             })
        }
    }
    
}
