import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Debug "mo:base/Debug";
import Nat32 "mo:base/Nat32";
import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Bool "mo:base/Bool";
import Int "mo:base/Int";
import Array "mo:base/Array";
import List "mo:base/List";
import Iter "mo:base/Iter";


actor Hastane_AracTakip {
  type Vehicle = {
    plate_number: Text;
    available: Bool;
  };
  type Hospital = {
    hospital_name: Text;
    vehicles: [Vehicle];
  };
  
   func natHash(n : Nat) : Hash.Hash { 
    Text.hash(Nat.toText(n))
  };

  
  let hastane = Map.HashMap<Nat, Hospital>(0, Nat.equal, natHash);
  var idCounter : Nat = 0;
   // createHospital
  public func createHospital(hospital_name: Text, vehicles: [Vehicle]) : async () {
    let id = idCounter;
    idCounter += 1;
    hastane.put(id, {hospital_name =hospital_name; vehicles = vehicles});
  };

  //Function that calls data added to "createHospital"
  public query func GetAllVehicles(): async [Hospital] {
    Iter.toArray(hastane.vals());

  };
  //The function where we add and update vehicles
  public func registerOrUpdate(hospital: Hospital, plate_number: Text, available: ?Bool): async () {
    var vehiclesIndex: Nat = 0;
    let hospitalIter = Iter.range(0, hospital.vehicles.size() - 1);

    label numberloop for (i in hospitalIter) {
      if (hospital.vehicles[i].plate_number == plate_number) {
        vehiclesIndex += i;
        break numberloop;
      }
    };
    
    // If the vehicle is found, update its availability
    if (vehiclesIndex < hospital.vehicles.size()) {
      
      Debug.print("Vehicle status successfully updated.");
    } else {
      // Handle the case where the vehicle is not found
      Debug.print("Vehicle not found.");
    };
  };
  //Function that regulates vehicle status according to received data (hospital, plate_number and status (current))
  public func updateVehicleStatus(hospital: Hospital, plate_number: Text, available: Bool): async() {
      let hospitalIter = Iter.range(0, hospital.vehicles.size() - 1);
      label numberloop for (i in hospitalIter) {
        if (hospital.vehicles[i].plate_number == plate_number){
          Debug.print("Vehicle status successfully updated.");
          break numberloop;
        }
      };
  };
  //Function that creates a vehicle request based on the hospital and license plate number received
  public func requestVehicle(hospital: Hospital, plate_number: Text): async() {
    let hospitalIter = Iter.range(0, hospital.vehicles.size() - 1);
    label numberloop for (i in hospitalIter) {
        if (plate_number == plate_number) {
          
          //hospital.[Vehicles].available := false;

          Debug.print("Araç talebi başarıyla gerçekleştirildi.");
          return;
        }
      }
    //Debug.print("Belirtilen plakaya sahip bir araç bulunamadı.");
  };
};