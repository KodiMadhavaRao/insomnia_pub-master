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
    Response response = await get('http://geekadvises.com/insomnia/gallery');
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String json = response.body;
    return json;
  }

  static getPackagesResponse() async {
    Response response =
        await get('http://geekadvises.com/insomnia/packages_data');
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static submitFeedBack(int user_id, int food, int service, int setting,
      int overall, String review) async {
    String url = 'http://geekadvises.com/insomnia/feedback_data';
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Map<String, String> feedbackdata = Map();
    feedbackdata["user_id"] = user_id.toString();
    feedbackdata["food_service"] = food.toString();
    feedbackdata["service"] = service.toString();
    feedbackdata["setting"] = setting.toString();
    feedbackdata["overall"] = overall.toString();
    feedbackdata["review"] = review.toString();
    Response response = await post(url, headers: headers, body: feedbackdata);

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
  static Future<String> saveTableReservation(
      Map<String, String> reservationData) async {
    String url = 'http://geekadvises.com/insomnia/reservations_data';
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Response response =
        await post(url, headers: headers, body: reservationData);
    int statusCode = response.statusCode;
    String body = response.body;
    return body;
  }

  static loginRequest(String mobile) async {
    String url = 'http://geekadvises.com/insomnia/loginmobile';
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Map<String, String> login = Map();
    login["mobile"] = mobile;
    Response response = await post(url, headers: headers, body: login);
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static singUpRequest(String username, String mobile) async {
    String url = 'http://geekadvises.com/insomnia/signup';
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Map<String, String> signup = Map();
    signup["mobile"] = mobile;
    signup["name"] = username;
    Response response = await post(url, headers: headers, body: signup);
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  static otpValidation(String mobile, String otp) async {
    String url = 'http://geekadvises.com/insomnia/otpverify';
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };
    Map<String, String> otpVerify = Map();
    otpVerify["mobile"] = mobile;
    otpVerify["otp"] = otp;
    Response response = await post(url, headers: headers, body: otpVerify);
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }
}
