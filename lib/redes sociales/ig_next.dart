import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../widgets/social_link.dart';
import '../utils/social_link.dart';

class IgNext extends ConsumerWidget {
  final String socialId;
  const IgNext(this.socialId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SocialLink(
      socialId: socialId,
      url: 'https://www.instagram.com/next.cci',
      platform: 'Instagram',
    );
  }
}
