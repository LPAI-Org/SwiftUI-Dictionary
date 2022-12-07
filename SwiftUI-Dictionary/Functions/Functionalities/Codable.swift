import SwiftUI

struct CustomerModel: Identifiable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()

    }
    func getData() {
        guard let data = getJSONData() else {return}
        
        if
            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
            let dictionary = localData as? [String: Any],
                let id = dictionary["id"] as? String,
                let name = dictionary["name"] as? String,
                let points = dictionary["points"] as?  Int,
                let isPremium = dictionary["isPremium"] as? Bool
        {

            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
            
            customer = newCustomer
        }
        
        
    }
    
    func getJSONData() -> Data? {
        //fake data
        let dictionary: [String:Any] = [
            "id": "12345",
            "name": "Adrian",
            "points": 5,
            "isPremium": true
        ]
     //convert it into json data
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        
        return jsonData
    }
}


struct Codable_Function: View {
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct Codable_Previews: PreviewProvider {
    static var previews: some View {
        Codable_Function()
    }
}
