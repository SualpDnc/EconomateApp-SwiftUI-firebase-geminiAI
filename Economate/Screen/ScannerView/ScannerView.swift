import SwiftUI


struct ScannerView: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @ObservedObject private var coordinator = ImagePickerCoordinator(image: .constant(nil), isShown: .constant(false))
 
        

    
    var body: some View {
        
        NavigationView {
            
            VStack {
      
                Button(action: {
                    self.showSheet = true
                }) {
                    VStack {
                        Spacer()
                        Image(systemName: "camera.circle")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .foregroundColor(.blue)
                         
                        Text("Scan Receipt")
                            .foregroundColor(.blue)
                            .font(.title)
                        
                        Spacer()
                        
                        Image("economate-logo")
                            .resizable()
                            .frame(width: 140, height: 80)
                            .padding(.top,0)
                    }
                    .padding()
                }
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                        .default(Text("Photo Library")) {
                            self.showImagePicker = true
                            self.sourceType = .photoLibrary
                        },
                        .default(Text("Camera")) {
                            self.showImagePicker = true
                            self.sourceType = .camera
                        },
                        .cancel()
                    ])
                }
                .fullScreenCover(isPresented: $coordinator.navigateToDashboard) {
                    DashboardView()
                }
                
              
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Receipt Scanner")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(Color(.label))
                        .padding(.top, 50)
                }
                
            }
           
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
