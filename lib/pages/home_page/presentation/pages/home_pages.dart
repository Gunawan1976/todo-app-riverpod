import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/components/text_view_widget.dart';
import 'package:todo_app/pages/add_activity_page/presentation/pages/add_activity_pages.dart';

import '../../../add_activity_page/presentation/controller/add_activity_controller.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages>
    with SingleTickerProviderStateMixin {
  final AddActivityController controller = Get.find();

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC3D2DD),
      appBar: AppBar(
        backgroundColor: Color(0xFFC3D2DD),
        title: TextView(text: "Todo App", isBold: true),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddActivityPages(),
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: "Hello!",
                  textColor: Colors.white,
                  fontSize: 32.sp,
                  isBold: true,
                ),
                TextView(
                  text:
                  "Hari ini,${DateFormat('dd MMMM yyyy').format(
                      DateTime.now())}",
                  textColor: Colors.white,
                  fontSize: 12.sp,
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                // Ukuran lingkaran
                lineWidth: 12.0,
                // Ketebalan garis
                percent: 5 / 7,
                // Nilai progress (antara 0.0 sampai 1.0)
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(
                      text: "5/7",
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0.sp,
                      textColor: Colors.white,
                    ),
                    TextView(text: "Completed", textColor: Colors.white),
                  ],
                ),
                progressColor: Colors.blue,
                // Warna progress
                backgroundColor: Colors.blue.shade100,
                // Warna background sisa
                circularStrokeCap:
                CircularStrokeCap.round, // Membuat ujungnya bulat
              ),
            ),
            SizedBox(height: 32.h),
            TabBar(
              indicatorColor: Color(0xFF3184C3),
              controller: tabController,
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.blue.shade100,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextView(
                        text: "Hari ini",
                        textColor: Color(0xFF3184C3),
                        isBold: true,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.blue.shade100,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextView(
                        text: "Akan Datang",
                        textColor: Color(0xFF3184C3),
                        isBold: true,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.blue.shade100,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextView(
                        text: "Selesai",
                        textColor: Color(0xFF3184C3),
                        isBold: true,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: [
                        SizedBox(
                          height: 200.h,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.notes.length,
                            itemBuilder: (context, index) =>
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Colors.white,
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: 10.h,
                                    left: 10.h,
                                    right: 10.h,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.circle, color: Colors.blue),
                                        SizedBox(width: 10.w),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            TextView(
                                              text: controller.notes[index].title ?? "",
                                              isBold: true,
                                              fontSize: 12.sp,
                                            ),
                                            TextView(
                                              text:"Hari ini,${DateFormat('dd MMMM yyyy').format(controller.notes[index].dueDate ?? DateTime.now())}",
                                              fontSize: 10.sp,
                                              textColor: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.blue,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextView(
                                text: "View All Activity",
                                textColor: Colors.white,
                                isBold: true,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                          onTap: () => print("View All Activity"),
                        ),
                      ],
                    );
                  }),
                  Column(
                    children: [
                      SizedBox(
                        height: 200.h,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) =>
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.only(
                                  bottom: 10.h,
                                  left: 10.h,
                                  right: 10.h,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.circle, color: Colors.blue),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            text: "LATIHAN FLUTTER UIX/UX",
                                            isBold: true,
                                            fontSize: 12.sp,
                                          ),
                                          TextView(
                                            text:
                                            "Hari ini,${DateFormat(
                                                'dd MMMM yyyy').format(
                                                DateTime.now())}",
                                            fontSize: 8.sp,
                                            textColor: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextView(
                              text: "View All Activity",
                              textColor: Colors.white,
                              isBold: true,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        onTap: () => print("View All Activity"),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 200.h,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) =>
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.only(
                                  bottom: 10.h,
                                  left: 10.h,
                                  right: 10.h,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.circle, color: Colors.blue),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          TextView(
                                            text: "LATIHAN FLUTTER UIX/UX",
                                            isBold: true,
                                            fontSize: 12.sp,
                                          ),
                                          TextView(
                                            text:
                                            "Hari ini,${DateFormat(
                                                'dd MMMM yyyy').format(
                                                DateTime.now())}",
                                            fontSize: 8.sp,
                                            textColor: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextView(
                              text: "View All Activity",
                              textColor: Colors.white,
                              isBold: true,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        onTap: () => print("View All Activity"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
