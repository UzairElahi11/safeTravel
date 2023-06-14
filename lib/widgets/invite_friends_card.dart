import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/app_images_path.dart';

class InviteFriendsCard extends StatelessWidget {
  const InviteFriendsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFFFF8A00),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Save money",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Get a power bank credit when you gift a friend a free charge.",
                      style: GoogleFonts.nunito(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 15),
                 
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Send a free charger",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 9),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
