
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:little_dino_app/app/constants/local_veriables.dart';
import 'package:little_dino_app/app/modules/login/providers/sigb_In_UsingEmil.dart';
import 'package:flutter/services.dart' show rootBundle;


class ProfileData{

  updateProfileInfo({required String userId,required String firstName,required String lastName,required profile,required String bornDate}) async {
    // ByteData bytes = await rootBundle.load(profile);
    try {
      var headers = {
        'auth-key': 'simplerestapi',
      };
      print("updateProfileInfo firstName ---------------->$firstName");
      print("updateProfileInfo lastName ---------------->$lastName");
      var request = http.MultipartRequest('POST', Uri.parse('http://tubfl.com/littledino/public/api/v1/edit/profile'));
      request.fields.addAll({
        'user_id': userId,
        'first_name': firstName,
        'last_name': lastName,
        'dob': bornDate,
      });
      // request.files.add(await http.MultipartFile.fromPath('profile', '$profile'));
      if(!profile.toString().contains('http')) {
        request.files.add(await http.MultipartFile.fromPath('profile', profile, filename: 'user_image'));
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print("response.statusCode of Edit Profile ---------------->${response.statusCode}");
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        OnlyEmailSign_In().getemailData(email: LocalVariables.emailId,isfromProfile: true);
      } else {
        print(response.reasonPhrase);
      }
    } catch(err) {
      print("updateProfileInfo Err ---------------->$err");
    }
  }
}

