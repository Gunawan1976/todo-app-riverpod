import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/edit_text_widget.dart';
import 'package:todo_app/components/text_view_widget.dart';
import 'package:todo_app/pages/add_activity_page/presentation/controller/add_activity_controller.dart';

class AddActivityPages extends StatefulWidget {
  const AddActivityPages({super.key});

  @override
  State<AddActivityPages> createState() => _AddActivityPagesState();
}

class _AddActivityPagesState extends State<AddActivityPages> {
  final AddActivityController controller = Get.find();

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController descriptionOptional = TextEditingController();
  DateTime dueDate = DateTime.now();

  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFC3D2DD),
      appBar: AppBar(
        title: TextView(text: "New Task", isBold: true),
        centerTitle: true,
        backgroundColor: Color(0xFFC3D2DD),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditText(
                customController: title,
                hintTextField: "What do you need to do?",
                fillColor: Colors.white,
              ),
              SizedBox(height: 20.h),
              EditText(
                customController: descriptionOptional,
                hintTextField: "Description(Optional)",
                fillColor: Colors.white,
              ),
              SizedBox(height: 20.h),
              EditText(
                customController: description,
                hintTextField: "Description",
                fillColor: Colors.white,
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101),
                  );
                  setState(() {
                    dueDate = picked!;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.date_range_sharp,
                          color: Colors.blue,
                          size: 40.sp,
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: "Due Date & Time",
                              isBold: true,
                              fontSize: 16.sp,
                            ),
                            TextView(
                              text:
                              "Hari ini,${DateFormat('dd MMMM yyyy').format(dueDate)}",
                              fontSize: 12.sp,
                              textColor: Colors.grey,
                            ),
                          ],
                        ),
                        Icon(Icons.keyboard_arrow_down, size: 40.sp),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Icon(Icons.timer, color: Colors.blue, size: 40.sp),
                  SizedBox(width: 10.w),
                  TextView(
                    text: "Reminder",
                    isBold: true,
                    textColor: Colors.blue,
                    fontSize: 16.sp,
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              SwitchListTile(
                contentPadding: const EdgeInsets.all(12.0),
                title: TextView(text: "Set Reminder", fontSize: 16.sp),
                // subtitle: const Text('Receive alerts and updates'),
                // secondary: const Icon(Icons.notifications),
                tileColor: Colors.white,
                value: _notificationsEnabled,
                activeThumbColor: Colors.white,
                activeTrackColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ), // Adjust 12.0 to change the roundness
                ),
                onChanged: (newValue) {
                  setState(() {
                    _notificationsEnabled = newValue;
                  });
                },
              ),
              SizedBox(height: 40.h),
              SizedBox(
                width: double.infinity,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    controller.addNote(
                      title: title.text,
                      desc: description.text,
                      dueDate: dueDate,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: TextView(
                    text: "Save Task",
                    isBold: true,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
