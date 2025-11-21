

class Guest {
  String name;
  String guestId;
  String phone;
  Guest(this.name, this.guestId, this.phone);
}

class Room {
  String numOfRoom;
  double pricePerNight;
  String TypeRoom;
  bool _isAvailable = true; 
  bool get isValed => _isAvailable;
  Room(this.numOfRoom, this.pricePerNight, this.TypeRoom);

  double costOfRoom(int nights) {
    return pricePerNight * nights;
  }

  void Type(int roomNumber) {
    if (roomNumber > 200 && roomNumber < 300) {
      print("This is VIP Room");
    } else if (roomNumber > 100 && roomNumber < 200) {
      print("This is Standard Room");
    }
  }
}



class Booking extends Room{
  Guest guest;
  Room room;
  String BookingId;
  int nights;

  Booking(this.BookingId, this.guest, this.room, this.nights,
    String numOfRoom, double pricePerNight, String TypeRoom)
    : super(numOfRoom, pricePerNight, TypeRoom);

  void BookRoom(String numOfRoom) {
    if (_isAvailable) {
      print("Room $numOfRoom is booked");
      _isAvailable = false;
    } else {
      print("Room $numOfRoom is not available");
    }
  }

  void checkOut(String nameGuest) {
    _isAvailable = true;
    print("Room $numOfRoom is valud now");
  }

  void totalPrice(nights) {
    double total = room.costOfRoom(nights);

    if (TypeRoom == "VIP") {
      total += 80.0; // Additional VIP fee
    }else if (TypeRoom == "standard") {
      total += 20.0; // Additional standard fee  
    }

    print("Total bill for ${guest.name}: $total");
  }
}

void main() {
  Room room1 = Room("101", 100, "standard");
  Room room2 = Room("102", 100, "standard");
  Room room3 = Room("201", 200, "VIP");
  Room room4 = Room("202", 200, "VIP");
  Guest guest1 = Guest("khaled", "K001", "01234567890");
  Guest guest2 = Guest("gamal", "g021", "01234567890");

  Booking booking1 = Booking("B001", guest1, room1, 3,"101", 100, "standard");
  Booking booking2 = Booking("B001", guest1, room2, 2,"102", 100, "standard");
  Booking booking3 = Booking("B002", guest2, room3, 5,"201", 200, "VIP");
  Booking booking4 = Booking("B002", guest2, room4, 4,"202", 200, "VIP");

    booking1.Type(101);
    booking1.BookRoom(room1.numOfRoom);
    booking1.BookRoom(room1.numOfRoom);
    booking1.totalPrice(booking1.nights);
    booking1.checkOut(guest1.name);
print("------------------------------------");
    booking2.Type(102);
    booking2.BookRoom(room2.numOfRoom);
    booking2.BookRoom(room2.numOfRoom);
    booking2.totalPrice(booking2.nights);
    booking2.checkOut(guest1.name);

print("------------------------------------");
    booking3.Type(201);
    booking3.BookRoom(room3.numOfRoom);
    booking3.BookRoom(room3.numOfRoom);
    booking3.totalPrice(booking3.nights);
    booking3.checkOut(guest2.name);
print("------------------------------------");
    booking4.Type(202);
    booking4.BookRoom(room4.numOfRoom);
    booking4.BookRoom(room4.numOfRoom);
    booking4.totalPrice(booking4.nights);
    booking4.checkOut(guest2.name);



}
