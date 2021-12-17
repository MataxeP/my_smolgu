import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_smolgu/controllers/task_controller.dart';
import 'package:my_smolgu/models/task.dart';
import 'package:my_smolgu/ui/services/theme_service.dart';
import 'package:my_smolgu/ui/widgets/input_field.dart';
import 'package:my_smolgu/ui/widgets/task_tile.dart';
import '../size_config.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
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
                    height: MediaQuery.of(context).size.height * 0.12,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        GestureDetector(
                            onTap: () async {
                              await Get.to(() => const AddTaskPage());
                              _taskController.getTasks();
                            },
                            child: Text(
                              "Новая задача",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Get.isDarkMode
                                    ? Theme.of(context).primaryColor
                                    : const Color(0XFF263064),
                              ),
                            ))
                      ],
                    )),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.72,
                  ),
                  decoration: BoxDecoration(
                    color: Get.isDarkMode ? Colors.black45 : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      _dateBar(),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            )));
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTaskMsg();
        } else {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _taskController.taskList.length,
              itemBuilder: (context, index) {
                Task task = _taskController.taskList[index];
                if (task.date ==
                    DateFormat("dd.MM.yyyy").format(_selectedDate)) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showBottomSheet(context, task);
                          },
                          child: TaskTile(task)),
                    ],
                  );
                } else {
                  return _noTaskMsg();
                }
              });
        }
      }),
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? SizeConfig.screenHeight * 0.24
            : SizeConfig.screenHeight * 0.32,
        width: SizeConfig.screenWidth,
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _buildBottomSheetButton(
                  label: "Задача завершена",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id!);
                    Get.back();
                  },
                  clr: primaryClr),
          _buildBottomSheetButton(
              label: "Удалить задачу",
              onTap: () {
                _taskController.deleteTask(task);
                Get.back();
              },
              clr: Colors.red[300]),
          const SizedBox(
            height: 20,
          ),
          _buildBottomSheetButton(
              label: "Закрыть",
              onTap: () {
                Get.back();
              },
              isClose: true),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  _buildBottomSheetButton(
      {String? label, Function()? onTap, Color? clr, bool isClose = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr!,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(label!,
                style: isClose
                    ? titleStyle
                    : titleStyle.copyWith(color: Colors.white))),
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/task.png",
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                  "У Вас до сих пор нет задач!\nСоздайте новую, чтобы стать продуктивнее.",
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
              () {
                _selectedDate = date;
              },
            );
          },
        ),
      ),
    );
  }
}

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.find<TaskController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InputField(
                    title: "Название",
                    hint: "Введите название для Вашей заметки",
                    maxLength: 50,
                    controller: _titleController,
                  ),
                  InputField(
                    title: "Дата",
                    hint: DateFormat("dd.MM.yyyy").format(_selectedDate),
                    size: 52,
                    widget: IconButton(
                      icon: (const Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.grey,
                      )),
                      onPressed: () {
                        _getDateFromUser();
                      },
                    ),
                  ),
                  InputField(
                    title: "Заметка",
                    hint: "О чём бы Вы хотели себе напомнить?",
                    controller: _noteController,
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _colorChips(),
                      GestureDetector(
                        onTap: () {
                          _validateInputs();
                        },
                        child: Container(
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0XFF263064),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Создать\nзадачу",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.raleway(
                                  textStyle:
                                      const TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _validateInputs() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Внимание!",
        "Всё поля должны быть заполнены.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: context.theme.backgroundColor,
      );
    } else {}
  }

  _addTaskToDB() async {
    await _taskController.addTask(
      task: Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat("dd.MM.yyyy").format(_selectedDate),
        color: _selectedColor,
        isCompleted: 0,
      ),
    );
  }

  _colorChips() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Цвет",
        style: titleStyle,
      ),
      const SizedBox(
        height: 8,
      ),
      Wrap(
        children: List<Widget>.generate(
          3,
          (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: index == _selectedColor
                      ? const Center(
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 18,
                          ),
                        )
                      : Container(),
                ),
              ),
            );
          },
        ).toList(),
      ),
    ]);
  }

  _appBar() {
    return AppBar(
      foregroundColor: Theme.of(context).primaryColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
          padding: const EdgeInsets.only(left: 24),
          icon: const Icon(Icons.keyboard_arrow_left_outlined),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Get.back();
          }),
      title: Text("Новая задача",
          style: GoogleFonts.raleway(
              textStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    );
  }

  _getDateFromUser() async {
    final DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2021),
        lastDate: DateTime(2121));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
}
