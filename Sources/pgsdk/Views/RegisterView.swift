import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var alertItem: AlertItem?
    @Binding var dataFromRegisterView: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Text("注册")
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

            SecureField("确认密码", text: $confirmPassword)
                .padding()
                .background(Color(hex: "F8F7FE"))
                .cornerRadius(12)
                .padding([.leading, .trailing, .bottom], 10)

            Button(action: {
                if username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                    alertItem = AlertItem(title: "注册失败", message: "用户名和密码不能为空")
                } else if password != confirmPassword {
                    alertItem = AlertItem(title: "注册失败", message: "两次输入的密码不一致")
                } else {
                    print("Username: \(username), Password: \(password)")
                    Pgoo.shared.register(username: username, password: password) { (res:AuthResponse?, error) in
                        if let _ = res {
                            if(res?.code != 1){
                                self.alertItem = AlertItem(title: "注册失败", message: (res?.msg!)!)
                            }else{
                                DispatchQueue.main.async {
                                    self.dataFromRegisterView = true
                                    self.presentationMode.wrappedValue.dismiss()
                                }

                            }
                        } else {
                            self.alertItem = AlertItem(title: "Error", message: "An error occurred during login")
                        }
                    }
                }
            }) {
                Text("注册")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding(.bottom, 10)

//            Button(action: {
//                // Implement your one-click registration functionality here
//            }) {
//                Text("一键注册")
//                    .foregroundColor(Color.white)
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(12)
//            }
//            .padding(.bottom, 10)
//
//            Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                Text("返回登录")
//                    .foregroundColor(Color.white)
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(12)
//            }

        }
        .padding()
        .alert(item: $alertItem) { currentItem in
            Alert(title: Text(currentItem.title), message: Text(currentItem.message), dismissButton: .default(Text("确定")))
        }
    }

    struct AlertItem: Identifiable {
        var id = UUID()
        var title: String
        var message: String
    }
}
