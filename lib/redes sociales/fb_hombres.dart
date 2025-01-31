import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../widgets/social_link.dart';
import '../utils/social_link.dart';

class FbHombres extends ConsumerWidget {
  final String socialId;
  const FbHombres(this.socialId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SocialLink(
      socialId: socialId,
      url: 'https://www.facebook.com/profile.php?id=100070401873657',
      platform: 'Facebook',
    );
  }
}
