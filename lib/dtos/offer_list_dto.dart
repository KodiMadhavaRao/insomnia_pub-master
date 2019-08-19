class OfferListDTO {
  String status;
  List<Message> message;

  OfferListDTO({this.status, this.message});

  OfferListDTO.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['message'] != null) {
      message = new List<Message>();
      json['message'].forEach((v) {
        message.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.message != null) {
      data['message'] = this.message.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String id;
  String specialOffersText;
  String image;

  Message({this.id, this.specialOffersText, this.image});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specialOffersText = json['special_offers_text'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['special_offers_text'] = this.specialOffersText;
    data['image'] = this.image;
    return data;
  }
}
