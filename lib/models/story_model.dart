import 'package:my_smolgu/ui/onboarding_screen.dart';

class Story {
  final String imgUrl;
  final Duration duration;
  final User user;
  final String title;
  final String desc;

  const Story({
    required this.title,
    required this.desc,
    required this.imgUrl,
    required this.duration,
    required this.user,
  });
}
