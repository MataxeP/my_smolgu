import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../main_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? Theme.of(context).backgroundColor
            : const Color(0xFFD4E7FE),
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
                Get.to(() => const MainPage());
              }),
          title: Text("Расписание",
              style: GoogleFonts.raleway(
                  textStyle: const TextStyle(fontSize: 24))),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Get.isDarkMode
                            ? Theme.of(context).backgroundColor
                            : const Color(0xFFD4E7FE),
                        Get.isDarkMode
                            ? Theme.of(context).backgroundColor
                            : const Color(0xFFF0F0F0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.6, 0.3])),
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: Get.isDarkMode
                              ? Colors.grey
                              : const Color(0XFF263064)),
                      const SizedBox(
                        width: 15,
                      ),
                      RichText(
                        text: TextSpan(
                            text: DateFormat.MMM('ru')
                                .format(DateTime.now())
                                .toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Get.isDarkMode
                                  ? Theme.of(context).primaryColor
                                  : const Color(0XFF263064),
                              fontSize: 22,
                            ),
                            children: [
                              TextSpan(
                                text: DateFormat(' y', 'ru')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Get.isDarkMode
                                      ? Theme.of(context).primaryColor
                                      : const Color(0XFF263064),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 60,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.black45 : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: _dateBar()),
                    _noLessonsMsg()
                  ],
                ),
              ),
            )
          ],
        ));
  }

  _noLessonsMsg() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/calendar.png",
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text("Сегодня у Вас нет занятий☺",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  )),
            ),
          ],
        ),
      ],
    );
  }

  _dateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 5),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: DatePicker(
          DateTime.now(),
          locale: "ru",
          initialSelectedDate: DateTime.now(),
          selectionColor: const Color(0XFF263064),
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.raleway(
            textStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.raleway(
            textStyle: const TextStyle(
              fontSize: 8.0,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.raleway(
            textStyle: const TextStyle(
              fontSize: 8.0,
              color: Colors.grey,
            ),
          ),
          onDateChange: (date) {
            setState(
              () {},
            );
          },
        ),
      ),
    );
  }
}
