import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_smolgu/models/story_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main_page.dart';
import 'services/auth_service.dart';
import 'services/theme_service.dart';

class OnBoardingScreen extends StatefulWidget {
  final List<Story> stories;

  const OnBoardingScreen({Key? key, required this.stories}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnBoardingScreen>
    with SingleTickerProviderStateMixin {
  PageController? _pageController;
  AnimationController? _animController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    final Story firstStory = widget.stories.first;
    _loadStory(story: firstStory, animateToPage: false);

    _animController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController!.stop();
        _animController!.reset();
        setState(() {
          if (_currentIndex + 1 < widget.stories.length) {
            _currentIndex += 1;
            _loadStory(story: widget.stories[_currentIndex]);
          } else {
            Get.to(() => const SignUpPage());
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    _animController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Story story = widget.stories[_currentIndex];
    return Scaffold(
      backgroundColor: const Color(0xFFD4E7FE),
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, story),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.stories.length,
              itemBuilder: (context, i) {
                final Story story = widget.stories[i];
                return ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                          Rect.fromLTRB(0, 270, rect.width, rect.height - 270));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      story.imgUrl,
                      fit: BoxFit.fitWidth,
                    ));
              },
            ),
            Positioned(
              top: 55.0,
              left: 20.0,
              right: 20.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: widget.stories
                        .asMap()
                        .map((i, e) {
                          return MapEntry(
                            i,
                            AnimatedBar(
                              animController: _animController!,
                              position: i,
                              currentIndex: _currentIndex,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.5,
                      vertical: 15.0,
                    ),
                    child: UserInfo(user: story.user),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 30,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: Text(story.title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  )))),
                          const SizedBox(height: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: Text(story.desc,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                    letterSpacing: 1,
                                    color: Colors.black,
                                    fontSize: 18,
                                  )))),
                          const SizedBox(height: 30),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => const SignUpPage());
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Text(
                                        "Начать",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ),
                                    ),
                                  ))),
                          const SizedBox(height: 20),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => const SignInPage());
                              },
                              child: Text("Уже есть аккаунт?",
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ))))
                        ]))))
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.stories.length) {
          _currentIndex += 1;
          _loadStory(story: widget.stories[_currentIndex]);
        }
      });
    }
  }

  void _loadStory({Story? story, bool animateToPage = true}) {
    _animController!.stop();
    _animController!.reset();
    _animController!.duration = story!.duration;
    _animController!.forward();
    if (animateToPage) {
      _pageController!.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key? key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 4.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.3,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 18.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: AssetImage(
            user.profileImageUrl,
          ),
        ),
        const SizedBox(width: 15.0),
        Expanded(
          child: Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

const User user = User(
  name: 'СмолГУ',
  profileImageUrl: 'assets/icons/smolgu_logo.png',
);

final List<Story> onboardStories = [
  const Story(
    imgUrl: 'assets/images/onboard-1.png',
    title: 'Привет! 👋',
    desc: "Задаёшься вопросом: зачем мне это приложение?",
    duration: Duration(seconds: 20),
    user: user,
  ),
  const Story(
    imgUrl: 'assets/images/onboard-2.png',
    title: 'Всё очень просто☺',
    desc: "Здесь ты найдёшь расписание своих занятий ",
    user: user,
    duration: Duration(seconds: 20),
  ),
  const Story(
    imgUrl: 'assets/images/onboard-3.png',
    title: 'А ТАКЖЕ...',
    desc: "тссс.. Навигацию по ВУЗу 🌈\nТолько никому",
    duration: Duration(seconds: 20),
    user: user,
  ),
];

class User {
  final String name;
  final String profileImageUrl;

  const User({
    required this.name,
    required this.profileImageUrl,
  });
}

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFD4E7FE),
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return const MainPage();
              } else if (snapshot.hasError) {
                return const Center(child: Text("Упс...Что-то пошло не так"));
              } else {
                return Stack(children: [
                  Align(
                      alignment: Alignment.center,
                      child: ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image.asset("assets/images/onboard-4.png",
                              fit: BoxFit.cover))),
                  Positioned(
                      bottom: 30,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Column(children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        child: Text("Добро пожаловать",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,
                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                            )))),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40,
                                        child: Text(
                                            "Пожалуйста, войдите в систему, чтобы получить доступ к личному кабинету",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,
                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                              letterSpacing: 1,
                                              color: Colors.black,
                                              fontSize: 18,
                                            )))),
                                    const SizedBox(height: 30),
                                    GestureDetector(
                                        onTap: () {
                                          final provider =
                                              Provider.of<GoogleSignInProvider>(
                                                  context,
                                                  listen: false);
                                          _storeOnBoardInfo();
                                          provider.googleLogin();
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child: Text(
                                                    "Продолжить с Google",
                                                    style: GoogleFonts.montserrat(
                                                        textStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white))),
                                              ),
                                            ))),
                                    const SizedBox(height: 20),
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(() => const SignUpPage());
                                        },
                                        child: Text('Ещё нет аккаунта?',
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ))))
                                  ])))))
                ]);
              }
            }));
  }
}

_storeOnBoardInfo() async {
  int isViewed = 0;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('onBoard', isViewed);
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

final TextEditingController _nameController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFD4E7FE),
        body: Stack(children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onchanged,
            controller: _controller,
            itemCount: 2,
            itemBuilder: (context, int index) {
              if (index == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Как тебя зовут?",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF263064)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        "Как к тебе обращаться?",
                        style: TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          letterSpacing: 0.7,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: _nameController,
                      maxLines: 1,
                      showCursor: false,
                      style: subTitleStyle.copyWith(
                          fontSize: 50, color: const Color(0x8B948F8B)),
                      obscureText: false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration.collapsed(
                        hintText: "Напиши имя",
                        hintStyle: subTitleStyle.copyWith(
                            fontSize: 50, color: const Color(0x8B948F8B)),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0XFF263064),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(15)),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                    )
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Просто авторизируйся. Без этого никак.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF263064)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          _storeOnBoardInfo();
                          provider.googleLogin();
                          if (_nameController.text.isNotEmpty) {
                            FirebaseAuth.instance.currentUser!
                                .updateDisplayName(_nameController.text);
                          }
                          Get.to(() => const SignInPage());
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "Приступить!",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                              ),
                            )))
                  ],
                );
              }
            },
          ),
          Positioned(
              top: 55,
              left: 0,
              right: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(2, (int index) {
                    return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 10,
                        width: (index == _currentPage) ? 30 : 10,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (index == _currentPage)
                                ? const Color(0XFF263064)
                                : const Color(0XFF263064).withOpacity(0.6)));
                  }))),
          Positioned(
              bottom: 30,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                              onTap: () {
                                Get.to(() => const SignInPage());
                              },
                              child: Text('Уже есть аккаунт?',
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ))))))))
        ]));
  }
}
