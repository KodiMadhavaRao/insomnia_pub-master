class GalleryListDTO {
  String status;
  List<Message> message;

  GalleryListDTO({this.status, this.message});

  GalleryListDTO.fromJson(Map<String, dynamic> json) {
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
//  String eventText;
  String image;

  Message({this.id/*, this.eventText*/, this.image});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
//    eventText = json['event_text'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
//    data['event_text'] = this.eventText;
    data['image'] = this.image;
    return data;
  }
}
