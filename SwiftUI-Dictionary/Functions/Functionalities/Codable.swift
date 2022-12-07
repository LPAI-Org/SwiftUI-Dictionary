import SwiftUI

// Codable = Decodable + Encodable
///if we apply i.e. CustomerModel: Decodable, Encodable. We would need to uncomment the entire lines below from Enum down to the last function of encode. With Codable, it is not required as it applies all those three closures for us behind the scene. 
struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    init(id: String, name: String, points: Int, isPremium: Bool) {
        self.id = id
        self.name = name
        self.points = points
        self.isPremium = isPremium
    }
    
    
    //Enum + init + func (decoder/encoder) required if you're using only CustomerModel with a Decodable + Encodable extension. If you use Codable, all the logic below is already done by the Codable protocol for us automatically, therefore reducing the amount of code required to write.
//    enum CodingKeys: CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.name, forKey: .name)
//        try container.encode(self.points, forKey: .points)
//        try container.encode(self.isPremium, forKey: .isPremium)
//    }
}

class CodableViewModel: ObservableObject {
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
        
    }
    func getData() {
        guard let data = getJSONData() else {return}
        
        //Third way - Most professional. Casting it with a try? that you can place the entire code in the previous version into one line
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)

        //Second way - We are taking an optional decodable and casting it in a do/catch closure if encase it doesnt have any data coming in.
//        do {
//            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
//        }
//        catch let error {
//            print("Error: \(error)")
//        }
        
        
        //First Way to decode JSON - This is the most inefficient way
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String: Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as?  Int,
//            let isPremium = dictionary["isPremium"] as? Bool {
//
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//
//            customer = newCustomer
//        }
        
        
    }
    
    func getJSONData() -> Data? {
        //fake JSON data
        
        ///Most efficient way to encode
        let customer = CustomerModel(id: "1111", name: "Tiffany", points: 100, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
        
        ///Most inefficient way to encode
//        let dictionary: [String:Any] = [
//            "id": "12345",
//            "name": "Adrian",
//            "points": 5,
//            "isPremium": true
//        ]
//        //convert it into json data
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary)
        
        //publishing json data out from jsonData
        return jsonData
    }
}


struct Codable_Function: View {
    //Importing the model
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
