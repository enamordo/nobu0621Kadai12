import SwiftUI

struct ContentView: View {
    // TODO: NSUserDfaultを利用
    // TODO: 空白の除去

    // 税抜金額
    @State private var amountIncludingTax = ""
    // 税込金額
    @State private var amountExcludingTax = 0
    // 消費税率
    @State private var consumptionTaxRate = ""

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("税抜金額")
                TextField("", text: $amountIncludingTax)
                    .roundedTextFieldStyle()
                Text("円")
                Spacer()
            }
            HStack {
                Spacer()
                Text("消費税率")
                TextField("", text: $consumptionTaxRate)
                    .roundedTextFieldStyle()
                Text("%")
                Spacer()
            }
            Button(action: {
                let tax = 1.0 + Double(consumptionTaxRate)! / 100
                amountExcludingTax = Int(Double(amountIncludingTax)! * tax)
            }, label: {
                Text("計算")
            })
            HStack {
                Spacer()
                Text("税込金額")
                Text(String(amountExcludingTax))
                    .frame(width: 100)
                Text("円")
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
//    func checkTextField() {
//        // 割られる数の入力存在チェック
//        // スペース除去も実施
//        guard let number1 = Float(amountIncludingTax.trimmingCharacters(in: .whitespaces)) else {
//            return
//        }
//        
//        // 割る数の入力存在チェック
//        // スペース除去も実施
//        guard  let number2 = Float(inputNumber2.trimmingCharacters(in: .whitespaces)) else {
//            return
//        }
//        
//        // 割る数の0チェック
//        if number2 == 0 {
//            alertType = .inputNumber2ZeroAlert
//            showAlert = true
//        } else {
//            result = number1 / number2
//        }
//    }
}

extension TextField {
    func roundedTextFieldStyle() -> some View {
        return self
            .textFieldStyle(.roundedBorder)
            .frame(width: 100)
            .keyboardType(.numberPad)
    }
}

#Preview {
    ContentView()
}
