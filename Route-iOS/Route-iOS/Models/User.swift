import Foundation

class User: NSObject {
    //Attributes
    private var firstName: String
    private var lastName: String
    private var email: String
    private var password: String
    private var zipCode: Int
    //---------------------------------------------------------------------------
    //Initializer
    init(fName: String, lName: String, email: String, pass: String, zip: Int) {
        self.firstName = fName
        self.lastName = lName
        self.email = email
        self.password = pass
        self.zipCode = zip
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
    
    func getPass() -> String {
        return self.password
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
    
    func setPass(pass: String){
        self.password = pass
    }
    
    func setEmail(email: String){
        self.email = email
    }
    
    func setZip(zip: Int){
        self.zipCode = zip
    }
    //----------------------------------------------------------------------------------
}
