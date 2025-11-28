import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../components/text_view_widget.dart';
import '../../../add_activity_page/presentation/provider/activity_providers.dart';

class AllUpcomingActivityPage extends ConsumerStatefulWidget {
  const AllUpcomingActivityPage({super.key});

  @override
  ConsumerState createState() => _AllTodayActivityPageState();
}

class _AllTodayActivityPageState extends ConsumerState<AllUpcomingActivityPage> {

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

  @override
  Widget build(BuildContext context) {
    final activityState = ref.watch(activityListProvider);
    final upcomingActivity = ref.watch(upcomingListProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF75AAE1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF75AAE1),
        title: TextView(text: "Todo App", isBold: true),
        centerTitle: true,
      ),
      body: activityState.when(
        loading: () =>
        const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (err, stack) => Center(
          child: TextView(
            text: 'Error: ${err.toString()}',
            textColor: Colors.red,
          ),
        ),
        data: (data) => Padding(
          padding: EdgeInsetsGeometry.all(24.0),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: upcomingActivity.length,
            itemBuilder: (context, index) =>
                _buildActivityItem(context, upcomingActivity[index]),
          ),
        ),
      ),
    );
  }
}
