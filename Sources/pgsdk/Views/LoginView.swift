import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var alertItem: AlertItem?
    @State private var dataFromRegisterView: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
        VStack {
            Text("登录")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            TextField("用户名", text: $username)
                .padding()
                .background(Color(hex: "F8F7FE"))
                .cornerRadius(12)
                .padding([.leading, .trailing], 10)

            SecureField("密码", text: $password)
                .padding()
                .background(Color(hex: "F8F7FE"))
                .cornerRadius(12)
                .padding([.leading, .trailing, .bottom], 10)

            Button(action: {
                if username.isEmpty || password.isEmpty {
                    alertItem = AlertItem(title: "登录失败", message: "用户名和密码不能为空")
                } else {
                    print("Username: \(username), Password: \(password)")
                    Pgoo.shared.login(username: username, password: password) { (res:AuthResponse?, error) in
                        if let _ = res {
                            if(res?.code != 1){
                                self.alertItem = AlertItem(title: "登录失败", message: (res?.msg!)!)
                            }else{
                                DispatchQueue.main.async {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    Pgoo.shared.state.isShowingLoginView = false
                                }
                            }
                        } else {
                            self.alertItem = AlertItem(title: "Error", message: "An error occurred during login")
                        }
                    }
                }
            }) {
                Text("   登录   ")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding(.bottom, 10)
            
            NavigationLink(destination: RegisterView(dataFromRegisterView: $dataFromRegisterView)) {
                               Text("   注册   ")
                                   .foregroundColor(Color.white)
                                   .padding()
                                   .background(Color.black)
                                   .cornerRadius(12)
                           }
                           .padding(.bottom, 10)

            Button(action: {
                Pgoo.shared.deviceLogin(uuid: UIDevice.current.identifierForVendor!.uuidString) { (res:AuthResponse?, error) in
                    if let _ = res {
                        if(res?.code != 1){
                            self.alertItem = AlertItem(title: "登录失败", message: (res?.msg!)!)
                        }else{
                            DispatchQueue.main.async {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                Pgoo.shared.state.isShowingLoginView = false
                            }
                        }
                    } else {
                        self.alertItem = AlertItem(title: "Error", message: "An error occurred during login")
                    }
                }
            }) {
                Text("一键试玩")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding(.bottom, 10)
            
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                    case .success(let authResults):
                        print("Authorisation successful")
                        if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
                                   let userID = appleIDCredential.user
                            print("User ID: \(userID)")
                            Pgoo.shared.thirdLogin(loginId: userID, loginType: "4") { (res:AuthResponse?, error) in
                                print(res)
                            }
                               }
                       
                    case .failure(let error):
                        print("Authorisation failed: \(error.localizedDescription)")
                }
            }
            // black button
            .signInWithAppleButtonStyle(.black)
            // white button
            .signInWithAppleButtonStyle(.white)
            // white with border
            .signInWithAppleButtonStyle(.whiteOutline).frame(width: 200, height: 50)
        }
        .padding()
        .alert(item: $alertItem) { currentItem in
            Alert(title: Text(currentItem.title), message: Text(currentItem.message), dismissButton: .default(Text("OK")))
        }.onAppear{
            let defaults = UserDefaults.standard
            if let token = defaults.object(forKey: "token") as? String {
                print("Token: \(token)")
                Pgoo.shared.tokenLogin(token: token) { (res:AuthResponse?, error) in
                    if let _ = res {
                        if(res?.code != 1){
                            self.alertItem = AlertItem(title: "登录失败", message: (res?.msg!)!)
                        }else{
                            DispatchQueue.main.async {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                Pgoo.shared.state.isShowingLoginView = false
                            }
                        }
                    } else {
                        self.alertItem = AlertItem(title: "Error", message: "An error occurred during login")
                    }
                }
            } else {
                print("Token is nil")
            }
        }
        }.onChange(of: dataFromRegisterView) { value in
            if value {
                DispatchQueue.main.async {
                    self.presentationMode.wrappedValue.dismiss()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Pgoo.shared.state.isShowingLoginView = false
                }
            }
        }
    }

    struct AlertItem: Identifiable {
        var id = UUID()
        var title: String
        var message: String
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
