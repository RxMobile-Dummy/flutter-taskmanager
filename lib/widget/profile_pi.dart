
import 'package:flutter/material.dart';
userProfilePic({radius=24.0,String? imagePath}) {
  return CircleAvatar(
    radius: radius,
    backgroundImage:  Image.network(
        (imagePath == null || imagePath == "")
        ? "https://mpng.subpng.com/20190123/jtv/kisspng-computer-icons-vector-graphics-person-portable-net-myada-baaranmy-teknik-servis-hizmetleri-5c48d5c2849149.051236271548277186543.jpg"
    : imagePath)
        .image,
  );
}
