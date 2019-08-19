class OffersData{
  String _id;
  String _offerText;
  String _image;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get offerText => _offerText;

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  set offerText(String value) {
    _offerText = value;
  }
  factory OffersData.fromJson(Map<String, dynamic> json) {
    return null;
  }

}