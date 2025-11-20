import 'dart:ffi';

void main() {
  Hotel hotel1 = Hotel("Dart Grand Hotel");
  Guest guest1 = Guest("Khaled Gamal", "G123", "012535465");
  Guest guest2 = Guest("mamon", "M559", "0115445465");
  Guest guest3 = Guest("ali", "a889", "0188205465");

  
  var res1 = hotel1.makeBooking(guest1, "VIP", DateTime.now(), 2);
  if (res1 != null) {
    (res1.room as VIP).useMiniBar(5); 
    res1.totalPrice();
  }
  print("---------------------------");

  var res2 = hotel1.makeBooking(guest2, "Standard", DateTime.now(), 4);
  if (res2 != null) {
    (res2.room as Standard); 
    res2.totalPrice();
  }
  print("---------------------------");

  var res3 = hotel1.makeBooking(guest3, "stand", DateTime.now(), 2);
  if (res3 != null) {
    (res3.room as Standard);
    res3.totalPrice();
  }
}

class Guest {
  String name;
  String guestId;
  String phone;
  Guest(this.name, this.guestId, this.phone);
}

abstract class Room {
  String numOfRoom;
  double pricePerNight;
  bool _isValed = true; // Encapsulation
  bool get isValed => _isValed;

  Room(this.numOfRoom, this.pricePerNight);

  bool BookRoom() {
    if (_isValed) {
      print("Room $numOfRoom is booked");
      _isValed = false;
    }
    return false;
  }

  void checkOut() {
    _isValed = true;
    print("Room $numOfRoom is valud now");
  }

  double costOfRoom(int nights) {
    return pricePerNight * nights;
  }
}

class VIP extends Room {
  double _juice = 30;

  VIP(String numOfRoom, double pricePerNight) : super(numOfRoom, pricePerNight);

  void useMiniBar(double amount) {
    _juice *= amount;
  }

  @override
  double costOfRoom(int nights) {
    double baseCost = super.costOfRoom(nights);
    double total = baseCost + _juice + 50.0; // +50.0 service fee
    print("VIP Cost: $total");
    return total;
  }
}

class Standard extends Room {
  Standard(String numOfRoom, double pricePerNight)
    : super(numOfRoom, pricePerNight);

  // No override, uses the parent's costOfRoom method
}

class Booking {
  Guest guest;
  Room room;

  String BookingId;
  DateTime checkInDate;
  int nights;

  Booking(this.BookingId, this.guest, this.room, this.checkInDate, this.nights);

  void totalPrice() {
    double total = room.costOfRoom(nights);
    print("Total bill for ${guest.name}: \$$total");
  }


}

class Hotel {
  String name;
  List<Room> rooms = [];

  Hotel(this.name) {
    // Add some rooms to the hotel
    rooms.add(Standard("101", 100));
    rooms.add(Standard("102", 100));
    rooms.add(VIP("201", 250));
    rooms.add(VIP("202", 250));
  }

  Booking? makeBooking(
    Guest guest,
    String roomType,
    DateTime checkIn,
    int nights,
  ) {
    final type = roomType.toLowerCase();
    Room? availableRoom;

    for (var room in rooms) {
      if (!room.isValed) continue;
      if ((type == 'vip' && room is VIP) ||
          (type == 'standard' && room is Standard)) {
        availableRoom = room;
        break;
      }
    }

    if (availableRoom == null) {
      print("Sorry, no $roomType rooms available.");
      return null;
    }

    availableRoom.BookRoom();
    final booking = Booking(
      DateTime.now().millisecondsSinceEpoch.toString(),
      guest,
      availableRoom,
      checkIn,
      nights,
    );

    print(
      "Booking confirmed for ${guest.name} in room ${availableRoom.numOfRoom}.",
    );
    return booking;
  }
}
