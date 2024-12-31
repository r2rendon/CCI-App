import 'package:flutter/material.dart';
import '../widgets/social_link.dart';

class FbHombres extends StatelessWidget {
  final String socialId;
  const FbHombres(this.socialId, {super.key});

  @override
  Widget build(BuildContext context) {
    return SocialLink(
      socialId: socialId,
      url: 'https://www.facebook.com/profile.php?id=100070401873657',
      platform: 'Facebook',
    );
  }
}
