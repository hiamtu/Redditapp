import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reddit_tutorial/models/community_model.dart';

class GenerateQR extends StatelessWidget {
  final String community;

  const GenerateQR({super.key, required this.community});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar having title
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          //Scroll view given to Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImage(data: community),
              const SizedBox(height: 20),
              const Center(
                  child: Text(
                "Generate QR Code",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
