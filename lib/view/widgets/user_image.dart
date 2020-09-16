import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({Key key, this.radius}) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      backgroundImage:
          Image.network('https://avatarfiles.alphacoders.com/146/146818.jpg')
              .image,
    );
  }
}
