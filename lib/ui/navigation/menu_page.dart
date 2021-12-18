import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:my_smolgu/ui/services/auth_service.dart';
import 'package:my_smolgu/ui/services/theme_service.dart';

class ModulesPage extends StatefulWidget {
  const ModulesPage({Key? key}) : super(key: key);

  @override
  _ModulesPageState createState() => _ModulesPageState();
}

class _ModulesPageState extends State<ModulesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Меню",
              style: GoogleFonts.raleway(
                  textStyle: const TextStyle(fontSize: 24))),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              ProfilePic(),
              const SizedBox(height: 20),
              ProfileMenu(
                text: "Мой профиль",
                icon: "assets/icons/menu_user_icon.svg",
                press: () {
                  Get.to(() => const ProfilePage());
                },
              ),
              ProfileMenu(
                text: "Настройки",
                icon: "assets/icons/menu_settings.svg",
                press: () {
                  Get.to(() => const SettingsPage());
                },
              ),
              ProfileMenu(
                text: "О приложении",
                icon: "assets/icons/menu_about.svg",
                press: () {
                  Get.to(() => const AboutPage());
                },
              ),
              ProfileMenu(
                text: "Нужна помощь?",
                icon: "assets/icons/menu_question.svg",
                press: () async {
                  await launch("https://vk.com/pmataxe", forceSafariVC: false);
                },
              ),
              ProfileMenu(
                text: "Выйти из аккаунта",
                icon: "assets/icons/menu_logout.svg",
                press: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
              ),
            ],
          ),
        ));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Get.isDarkMode ? Colors.white : const Color(0XFF343E87),
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor:
              Get.isDarkMode ? Colors.black45 : const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Get.isDarkMode ? Colors.white : const Color(0XFF343E87),
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: GoogleFonts.raleway())),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  ProfilePic({
    Key? key,
  }) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() => const ProfilePage());
        },
        child: SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          user.photoURL!,
                        ))),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      color: const Color(0XFF343E87),
                    ),
                    child: const Icon(
                      Icons.people_rounded,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ));
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              padding: const EdgeInsets.only(left: 24),
              icon: const Icon(Icons.keyboard_arrow_left_outlined),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Get.back();
              }),
          title: Text("Настройки",
              style: GoogleFonts.raleway(
                  textStyle: const TextStyle(fontSize: 24))),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 22, left: 16, right: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Тёмная тема",
                          style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ))),
                      const Spacer(),
                      CupertinoSwitch(
                          trackColor: Colors.red,
                          activeColor: const Color(0XFF343E87),
                          value: _loadThemeFromBox(),
                          onChanged: (newValue) {
                            switchTheme();
                          })
                    ]))
          ],
        ));
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isNotEmpty ? subtitle : 'Not set'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            padding: const EdgeInsets.only(left: 24),
            icon: const Icon(Icons.keyboard_arrow_left_outlined),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Get.back();
            }),
        title: Text("Инфо",
            style:
                GoogleFonts.raleway(textStyle: const TextStyle(fontSize: 24))),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            children: <Widget>[
              Container(
                width: constraints.maxWidth,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Column(
                  children: <Widget>[
                    ClipOval(
                        child: CircleAvatar(
                      radius: 64,
                      backgroundColor: primaryClr,
                      child: Image.asset("assets/icons/app_icon.png"),
                    )),
                    const SizedBox(height: 16),
                    _infoTile('Название пакета: ', _packageInfo.packageName),
                    _infoTile('Версия: ', _packageInfo.version),
                    _infoTile('Номер сборки: ', _packageInfo.buildNumber),
                  ],
                ),
              ),
              const Divider(height: 1),
              SettingsCategory(
                header: "Разработчики",
                children: List.generate(
                  3,
                  (index) =>
                      contributorTile(context, Constants.contributors[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget contributorTile(BuildContext context, ContributorInfo info) {
    return ListTile(
      trailing: GestureDetector(
          onTap: () async {
            await launch(info.vkURL, forceSafariVC: false);
          },
          child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/icons/vk_logo.png"))),
      leading: CircleAvatar(backgroundImage: AssetImage(info.avatarUrl)),
      title: Text(info.name),
      subtitle: Text(info.role),
    );
  }
}

@immutable
class ContributorInfo {
  final String name;
  final String role;
  final String avatarUrl;
  final String vkURL;

  const ContributorInfo({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.vkURL,
  });
}

class Constants {
  Constants._();
  static List<ContributorInfo> get contributors => [
        const ContributorInfo(
            name: "Бучачий Дмитрий",
            role: "Разработчик/UI-UX дизайн",
            avatarUrl: "assets/images/developer_1.png",
            vkURL: "https://vk.com/pmataxe"),
        const ContributorInfo(
            name: "Жуков Егор",
            role: "UI-UX/Сбор данных",
            avatarUrl: "assets/images/developer_2.png",
            vkURL: "https://vk.com/zu40k"),
        const ContributorInfo(
            name: "Моторин Илья",
            role: "Разработчик/3D-моделирование",
            avatarUrl: "assets/images/developer_3.png",
            vkURL: "https://vk.com/motoilyuha"),
      ];
}

class SettingsCategory extends StatelessWidget {
  final String header;
  final List<Widget> children;

  const SettingsCategory({
    Key? key,
    required this.header,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            32,
            8,
            16,
            8,
          ),
          child: headerWidget(header),
        ),
        ...children,
      ],
    );
  }

  Widget headerWidget(String text) => Builder(
        builder: (context) => Text(
          text.toUpperCase(),
          style: GoogleFonts.raleway(
              textStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 2,
          )),
        ),
      );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            padding: const EdgeInsets.only(left: 24),
            icon: const Icon(Icons.keyboard_arrow_left_outlined),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Get.back();
            }),
        title: Text("Профиль",
            style:
                GoogleFonts.raleway(textStyle: const TextStyle(fontSize: 24))),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                user.photoURL!,
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: const Color(0XFF343E87),
                          ),
                          child: const Icon(
                            Icons.people_rounded,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextField("Имя", user.displayName!),
              buildTextField("E-mail", user.email!),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return ListTile(
      title: Text(labelText),
      subtitle: Text(placeholder,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
