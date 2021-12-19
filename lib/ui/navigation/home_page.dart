import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_smolgu/models/task.dart';
import 'package:my_smolgu/ui/services/theme_service.dart';
import 'package:my_smolgu/controllers/task_controller.dart';

import 'notes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
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
                  height: MediaQuery.of(context).size.height * 0.13,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width - 150,
                                  child: Text(
                                    "Привет, " + user.displayName.toString(),
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: Get.isDarkMode
                                          ? Theme.of(context).primaryColor
                                          : const Color(0XFF343E87),
                                    ),
                                  )),
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
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.71,
                  ),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? Colors.black45 : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ВАШИ ЗАМЕТКИ",
                              style: GoogleFonts.montserrat(
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
                                  style: GoogleFonts.montserrat(
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
                                        style: GoogleFonts.montserrat()),
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
            style: GoogleFonts.montserrat(
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
                style: GoogleFonts.montserrat(
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
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
