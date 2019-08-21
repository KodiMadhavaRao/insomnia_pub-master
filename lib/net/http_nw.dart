import 'package:http/http.dart';
import 'dart:convert';

class AppHttpRequest {
  static getOffersResponse() async {
    Response response =
        await get('http://geekadvises.com/insomnia/special_offers_data');
//    int statusCode = response.statusCode;
//    Map<String, String> headers = response.headers;
//    String contentType = headers['content-type'];
//    String json = response.body;
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static getEventListResponse() async {
    Response response =
        await get('http://geekadvises.com/insomnia/events_data');
//    int statusCode = response.statusCode;
//    Map<String, String> headers = response.headers;
//    String contentType = headers['content-type'];
//    String json = response.body;

    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static getGalleryResponse() async {
    Response response =
        await get('http://geekadvises.com/insomnia/gallery');
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String json = response.body;
    return json;
  }

  static getPackagesResponse() async {
    Response response = await get('http://geekadvises.com/insomnia/packages_data');
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String json = response.body;
    return json;
  }

  static submitFeedBack(int user_id, String food, String service,
      String setting, String overall, String review) async {
    // set up PUT request arguments
    String url = 'http://geekadvises.com/insomnia/feedback_data';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json =
        '{user_id: $user_id,food: $food,service: $service,setting: $setting,overall: $overall,review: $review,}}';
    // make PUT request
    Response response = await put(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the updated item with the id added
    String body = response.body;
    // {
    //   "title": "Hello",
    //   "body": "body text",
    //   "userId": 1,
    //   "id": 1
    // }
    return response.body;
  }

  static reservationBook() async {
    // set up PUT request arguments
    String url = 'http://geekadvises.com/insomnia/reservations_data';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"title": "Hello", "body": "body text", "userId": 1}';
    // make PUT request
    Response response = await put(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the updated item with the id added
    String body = response.body;
    // {
    //   "title": "Hello",
    //   "body": "body text",
    //   "userId": 1,
    //   "id": 1
    // }
  }
  /*user_id:123
  user_name:MM
  user_mobile:88
  males:2
  females:2
  members:4*/
  static Future<String> saveTableReservation(Map<String,String> reservationData) async {
    String url = 'http://geekadvises.com/insomnia/reservations_data';
    Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
    Response response = await post(url, headers: headers, body: reservationData);
    int statusCode = response.statusCode;
    String body = response.body;
    return body;

  }

}

final _root = 'https://hacker-news.firebaseio.com/v0';
