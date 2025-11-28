import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/edit_text_widget.dart';
import 'package:todo_app/components/text_view_widget.dart';

// Import Entities dan Notifier
import '../../domain/entities/add_activity_entity.dart';
import '../provider/activity_providers.dart';


// Ganti StatefulWidget dengan ConsumerStatefulWidget
class AddActivityPages extends ConsumerStatefulWidget {
  const AddActivityPages({super.key});

  @override
  ConsumerState<AddActivityPages> createState() => _AddActivityPagesState();
}

// Ganti State dengan ConsumerState
class _AddActivityPagesState extends ConsumerState<AddActivityPages> {
  // final AddActivityController controller = Get.find(); // Dihapus

  // Text Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController descriptionOptionalController = TextEditingController();

  // State Lokal
  DateTime dueDate = DateTime.now();
  bool _notificationsEnabled = true;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    descriptionOptionalController.dispose();
    super.dispose();
  }

  // Fungsi untuk menampilkan Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dueDate,
      firstDate: dueDate,
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != dueDate) {
      // Tambahkan logic Time Picker jika dibutuhkan di masa depan
      setState(() {
        dueDate = picked;
      });
    }
  }

  // Fungsi untuk menyimpan data (Memanggil Riverpod Notifier)
  void _saveTask() {
    // 1. Validasi Sederhana
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan Deskripsi utama wajib diisi.')),
      );
      return;
    }

    // 2. Buat Entity baru
    final newTask = AddActivityEntity(
      // Asumsi isCompleted defaultnya false
      title: titleController.text,
      description: descriptionController.text,
      descriptionOptional: descriptionOptionalController.text,
      dueDate: dueDate,
      // isCompleted: false, // Perlu ditambah di Entity/Model jika belum ada
    );

    // 3. Panggil Notifier (Riverpod) untuk menambahkan data
    // Gunakan ref.read untuk mengakses fungsi
    ref.read(activityListProvider.notifier).addNote(newTask);

    // 4. Kembali ke halaman sebelumnya
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFC3D2DD),
      appBar: AppBar(
        title: TextView(text: "New Task", isBold: true),
        centerTitle: true,
        backgroundColor: const Color(0xFFC3D2DD),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditText(
                customController: titleController,
                hintTextField: "What do you need to do?",
                fillColor: Colors.white,
              ),
              SizedBox(height: 20.h),
              EditText(
                customController: descriptionOptionalController,
                hintTextField: "Description(Optional)",
                fillColor: Colors.white,
              ),
              SizedBox(height: 20.h),
              EditText(
                customController: descriptionController,
                hintTextField: "Description",
                fillColor: Colors.white,
              ),
              SizedBox(height: 20.h),

              // Date Picker
              InkWell(
                onTap: () => _selectDate(context),
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
                              text: "Hari ini,${DateFormat('dd MMMM yyyy').format(dueDate)}",
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

              // Reminder Section
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
                tileColor: Colors.white,
                value: _notificationsEnabled,
                activeThumbColor: Colors.white,
                activeTrackColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onChanged: (newValue) {
                  setState(() {
                    _notificationsEnabled = newValue;
                  });
                },
              ),

              SizedBox(height: 40.h),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: _saveTask, // Panggil fungsi _saveTask
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