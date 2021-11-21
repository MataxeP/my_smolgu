import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_smolgu/controllers/schedule_controller.dart';
import 'package:my_smolgu/models/task.dart';
import 'package:my_smolgu/ui/services/theme_service.dart';
import 'package:my_smolgu/controllers/task_controller.dart';

import 'notes_page.dart';
import 'schedule_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _taskController = Get.put(TaskController());
  final _scheduleController = Get.put(ScheduleController());

  @override
  void initState() {
    super.initState();
    _scheduleController.readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? Theme.of(context).backgroundColor
            : const Color(0xFFD4E7FE),
        body: Container(
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
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 1, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.2),
                                  blurRadius: 12,
                                  spreadRadius: 8,
                                )
                              ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(user.photoURL.toString()),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Привет, " + user.displayName.toString(),
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Get.isDarkMode
                                      ? Theme.of(context).primaryColor
                                      : const Color(0XFF343E87),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Чем займёмся сегодня?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? Colors.black45 : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ВАШИ ЗАНЯТИЯ",
                              style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Theme.of(context).primaryColor
                                    : Colors.black,
                              ))),
                          TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(15)),
                              ),
                              onPressed: () {
                                Get.to(() => const SchedulePage());
                              },
                              child: Text("Просмотреть все",
                                  style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                          color: Get.isDarkMode
                                              ? Theme.of(context).primaryColor
                                              : const Color(0XFF3E3993),
                                          fontSize: 13))))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.all(10),
                            height: 230,
                            decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? Theme.of(context).backgroundColor
                                  : const Color(0xFFF9F9FB),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("У Вас не выбрана группа!🙃",
                                    style: GoogleFonts.raleway()),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ВАШИ ЗАМЕТКИ",
                              style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Get.isDarkMode
                                    ? Theme.of(context).primaryColor
                                    : Colors.black,
                              ))),
                          TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(15)),
                              ),
                              onPressed: () {
                                Get.to(() => const NotesPage());
                              },
                              child: Text("Просмотреть все",
                                  style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                          color: Get.isDarkMode
                                              ? Theme.of(context).primaryColor
                                              : const Color(0XFF3E3993),
                                          fontSize: 13))))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Obx(() {
                            if (_taskController.taskList.isEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? Theme.of(context).backgroundColor
                                      : const Color(0xFFF9F9FB),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("У Вас нет сохранённых заметок!😏",
                                        style: GoogleFonts.raleway()),
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox(
                                  height: 140,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          _taskController.taskList.length,
                                      itemBuilder: (context, index) {
                                        Task task =
                                            _taskController.taskList[index];
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      () => const NotesPage());
                                                },
                                                child: buildTaskItem(task))
                                          ],
                                        );
                                      }));
                            }
                          })
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )));
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }

  Container buildTaskItem(Task task) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        color: _getBGClr(task.color!).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.isCompleted == 0 ? "TODO" : "ЗАВЕРШЕНО",
            style: GoogleFonts.raleway(
                textStyle: const TextStyle(fontSize: 10, color: Colors.grey)),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: _getBGClr(task.color!),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                task.date.toString(),
                style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 100,
            child: Text(
              task.title!,
              maxLines: 3,
              style: GoogleFonts.raleway(
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Container buildClassItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? Theme.of(context).backgroundColor
            : const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("07:00",
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.isDarkMode
                            ? Theme.of(context).primaryColor
                            : const Color(0xFFD4E7FE)),
                  )),
            ],
          ),
          Container(
            height: 100,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Text("The Basic of Typography II",
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.raleway()),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      "Room C1, Faculty of Art & Design Building",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              color: Colors.grey, fontSize: 13)),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=80"),
                    radius: 10,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Gabriel Sutton",
                    style: GoogleFonts.raleway(
                        textStyle:
                            const TextStyle(color: Colors.grey, fontSize: 13)),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
