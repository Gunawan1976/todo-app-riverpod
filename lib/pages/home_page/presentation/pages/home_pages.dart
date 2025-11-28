import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/components/text_view_widget.dart';
import 'package:todo_app/pages/add_activity_page/presentation/pages/add_activity_pages.dart';
import '../../../add_activity_page/presentation/provider/activity_providers.dart';

// Ganti StatefulWidget dengan ConsumerStatefulWidget
class HomePages extends ConsumerStatefulWidget {
  const HomePages({super.key});

  @override
  ConsumerState<HomePages> createState() => _HomePagesState();
}

// Ganti State dengan ConsumerState
class _HomePagesState extends ConsumerState<HomePages>
    with SingleTickerProviderStateMixin {
  // final AddActivityController controller = Get.find(); // Dihapus

  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      // Tidak perlu setState, karena Riverpod yang akan handle update data
      // Tapi kita butuh setState jika ada perubahan tampilan yang tidak terkait data (e.g. indikator TabController)
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // Widget helper untuk list item (dibuat di luar build agar rapi)
  Widget _buildActivityItem(BuildContext context, dynamic item, {Color color = Colors.blue}) {
    final dueDate = item.dueDate ?? DateTime.now();
    final title = item.title ?? "";

    return Container(
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
            Icon(Icons.circle, color: color),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: title,
                  isBold: true,
                  fontSize: 12.sp,
                ),
                TextView(
                  text: "Hari ini,${DateFormat('dd MMMM yyyy').format(dueDate)}",
                  fontSize: 10.sp,
                  textColor: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun ListView di dalam Tab
  Widget _buildTabListView(List<dynamic> activities) {
    // Kita hanya perlu check activities.isEmpty karena state loading/error
    // sudah dihandle di level paling atas (activityState.when)
    if (activities.isEmpty) {
      return Center(child: TextView(text: "Tidak ada aktivitas."));
    }

    return Column(
      children: [
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: activities.length,
            itemBuilder: (context, index) =>
                _buildActivityItem(context, activities[index]),
          ),
        ),
        InkWell(
          onTap: () => print("View All Activity"),
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
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    // 1. Ganti Get.find() dengan ref.watch()
    final activityState = ref.watch(activityListProvider);
    final todayActivities = ref.watch(upcomingListProvider);
    final upcomingActivities = ref.watch(upcomingListProvider);
    final completedActivities = ref.watch(upcomingListProvider);

    // Hitung progress di sini
    final total = activityState.value?.length ?? 0;
    final completedCount = completedActivities.length;
    final progress = total > 0 ? completedCount / total : 0.0;


    return Scaffold(
      backgroundColor: const Color(0xFF75AAE1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF75AAE1),
        title: TextView(text: "Todo App", isBold: true),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // Navigasi tetap sama
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddActivityPages(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),

      // 2. Gunakan .when() untuk handling Loading/Error di Body
      body: activityState.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (err, stack) => Center(child: TextView(text: 'Error: ${err.toString()}', textColor: Colors.red)),
        data: (allData) => Padding( // Data sukses dimuat, tampilkan UI
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Bagian Header (Sama)
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
                    text: "Hari ini,${DateFormat('dd MMMM yyyy').format(DateTime.now())}",
                    textColor: Colors.white,
                    fontSize: 12.sp,
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Circular Progress Indicator
              Center(
                child: CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 12.0,
                  percent: progress, // Gunakan progress dari Riverpod
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextView(
                        text: "$completedCount/$total", // Gunakan count dari Riverpod
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0.sp,
                        textColor: Colors.white,
                      ),
                      TextView(text: "Completed", textColor: Colors.white),
                    ],
                  ),
                  progressColor: Colors.blue,
                  backgroundColor: Colors.blue.shade100,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
              SizedBox(height: 32.h),

              // TabBar (Sama)
              TabBar(
                indicatorColor: const Color(0xFF3184C3),
                controller: tabController,
                tabs: const [ // Dibuat const karena tidak ada perubahan di sini
                  Tab(child: _TabItem(text: "Hari ini")),
                  Tab(child: _TabItem(text: "Akan Datang")),
                  Tab(child: _TabItem(text: "Selesai")),
                ],
              ),
              SizedBox(height: 10.h),

              // TabBarView
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    // Tab 1: Hari Ini
                    _buildTabListView(todayActivities),

                    // Tab 2: Akan Datang
                    _buildTabListView(upcomingActivities),

                    // Tab 3: Selesai
                    _buildTabListView(completedActivities),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Widget untuk Tab Item (dibuat di luar agar lebih clean)
class _TabItem extends StatelessWidget {
  final String text;
  const _TabItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.blue.shade100,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextView(
          text: text,
          textColor: const Color(0xFF3184C3),
          isBold: true,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}