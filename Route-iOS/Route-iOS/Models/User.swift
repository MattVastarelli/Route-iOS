import Foundation

class User: NSObject {
    //Attributes
    private var firstName: String
    private var lastName: String
    private var email: String
    private var zipCode: Int
    //---------------------------------------------------------------------------
    //Initializer
    init(fName: String, lName: String) {
        self.firstName = fName
        self.lastName = lName
        self.email = "email"
        self.zipCode = -1
    }
    //--------------------------------------------------------------------------------
    // Account Getters
    func getFirstName() -> String {
        return self.firstName
    }
    
    func getLastName() -> String {
        return self.lastName
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    
    func getZip() -> Int {
        return self.zipCode
    }
    
    // Account Setters
    func setFirstName(name: String){
        self.firstName = name
    }
    
    func setLastName(name: String){
        self.lastName = name
    }
    
    func setEmail(email: String){
        self.email = email
    }
    
    func setZip(zip: Int){
        self.zipCode = zip
    }
    //----------------------------------------------------------------------------------
    
    func getUserCollection() -> [String: Any] {
        let userCollection = [
            "first name": self.firstName,
            "last name": self.lastName,
            "email": self.email,
            "zip code": self.zipCode,
            ] as [String : Any]
        
        return userCollection
    }
}
