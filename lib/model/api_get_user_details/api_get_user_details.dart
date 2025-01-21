// To parse this JSON data, do
//
//     final apiGetUserDetails = apiGetUserDetailsFromJson(jsonString);

import 'dart:convert';

ApiGetUserDetails apiGetUserDetailsFromJson(String str) => ApiGetUserDetails.fromJson(json.decode(str));

String apiGetUserDetailsToJson(ApiGetUserDetails data) => json.encode(data.toJson());

class ApiGetUserDetails {
    String? name;
    String? phoneNumber;

    ApiGetUserDetails({
        this.name,
        this.phoneNumber,
    });

    factory ApiGetUserDetails.fromJson(Map<String, dynamic> json) => ApiGetUserDetails(
        name: json["name"],
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone_number": phoneNumber,
    };
}
