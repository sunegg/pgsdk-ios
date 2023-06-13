import SwiftUI

struct RealVerifyView: View {
    @State private var name: String = ""
    @State private var idNumber: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var alertItem: AlertItem?

    var body: some View {
        VStack {
            Text("实名认证")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            TextField("名字", text: $name)
                .padding()
                .background(Color(hex: "F8F7FE"))
                .cornerRadius(12)
                .padding([.leading, .trailing], 10)

            SecureField("身份证号码", text: $idNumber)
                .padding()
                .background(Color(hex: "F8F7FE"))
                .cornerRadius(12)
                .padding([.leading, .trailing], 10)

            Button(action: {
                if name.isEmpty || idNumber.isEmpty {
                    alertItem = AlertItem(title: "Error", message: "名字和身份证号码不能为空")
                } else {
                    print("Name: \(name), ID Number: \(idNumber)")
                    Pgoo.shared.realVerify(realName: name, idNo: idNumber) { (res:BaseResponse?, error) in
                        if let _ = res {
                         if(res?.code != 1){
                            self.alertItem = AlertItem(title: "实名认证失败", message: (res?.msg!)!)
                         }else{
                            DispatchQueue.main.async {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                Pgoo.shared.state.isShowingRealVerifyView = false
                            }
                         }
                        } else {
                            self.alertItem = AlertItem(title: "Error", message: "An error occurred during real verify")
                        }
                    }
                }
            }) {
                Text("提交")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(12)
            }
            .padding()
            .alert(item: $alertItem) { item in
                Alert(title: Text(item.title), message: Text(item.message), dismissButton: .default(Text("OK")))
            }

            Text("按照《国家新闻出版署关于进一步严格管理 切实防止未成年人沉迷网络游戏的通知》的相关要求，网络游戏用户需要使用有效身份证进行实名认证，方可进入游戏和支付。")
                .font(.footnote)
                .foregroundColor(.orange)
                .padding()
        }
        .padding()
    }

    struct AlertItem: Identifiable {
        var id = UUID()
        var title: String
        var message: String
    }
}
