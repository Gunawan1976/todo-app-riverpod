import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/pages/home_page/presentation/pages/home_pages.dart';

import 'components/text_view_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3678AC),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween, // <-- Hapus ini
        children: [
          // 1. Widget ini akan mengambil semua sisa ruang
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check, size: 100.sp, color: Colors.white),
                  TextView(
                    text: 'Todo App',
                    textColor: Colors.white,
                    fontSize: 30.sp,
                  ),
                ],
              ),
            ),
          ),

          // 2. Widget ini akan 'terdorong' ke bawah
          Padding(
            padding: EdgeInsets.only(top: 8.w, bottom: 55.w, left: 16.r, right: 16.r),
            child: SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePages(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: TextView(text: "Get Started"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}