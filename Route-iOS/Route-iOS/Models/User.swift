import Foundation
import Firebase

class User: NSObject {
    //Attributes
    private var firstName: String
    private var lastName: String
    private var email: String
    private var zipCode: Int
    private var id: String
    // list of sting document ids for their routes
    private var myRoutes = Array<String>()
    // list of string document ids for their saved
    private var mySavedRoutes = Array<String>()
    
    //---------------------------------------------------------------------------
    //Initializer
    init(fName: String, lName: String) {
        self.firstName = fName
        self.lastName = lName
        self.email = "email"
        self.zipCode = -1
        self.id = ""
    }
    //--------------------------------------------------------------------------------
    // Account Getters
    func getFirstName() -> String {
        return self.firstName
    }
    
    func getID() -> String {
        return self.id
    }
    
    func getLastName() -> String {
        return self.lastName
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getMyRoutes() -> [String] {
        return self.myRoutes
    }
    
    func getMySavedRoutes() -> [String] {
        return self.mySavedRoutes
    }
    
    func getZip() -> Int {
        return self.zipCode
    }
    
    // Account Setters
    func setFirstName(name: String){
        self.firstName = name
    }
    
    func setID(id: String){
        self.id = id
    }
    
    func addRoute(id: String) {
        self.myRoutes.append(id)
    }
    
    func addSavedRoute(id: String) {
        self.mySavedRoutes.append(id)
    }
    
    func setLastName(name: String){
        self.lastName = name
    }
    
    func setMyRoutes(routes: [String]) {
        self.myRoutes = routes
    }
    
    func setMySavedRoutes(savedRoutes: [String]) {
        self.mySavedRoutes = savedRoutes
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
    
    // save the user
    func save() {
        //firestore
        let db = Firestore.firestore()
        // refrence for firebase
        var ref: DocumentReference? = nil
        
        // save the record
        ref = db.collection("Users").addDocument(data: [
            "first name": self.firstName,
            "last name": self.lastName,
            "email": self.email,
            "zip code": self.zipCode,
            "my routes": self.myRoutes,
            "saved routes": self.mySavedRoutes
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                // possible call update to user
            }
        }
    }
    
    // update the users document
    func update() {
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(self.id)
        
        userRef.updateData([
            "first name": self.firstName,
            "last name": self.lastName,
            "email": self.email,
            "zip code": self.zipCode,
            "my routes": self.myRoutes,
            "saved routes": self.mySavedRoutes
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }

    }
}
