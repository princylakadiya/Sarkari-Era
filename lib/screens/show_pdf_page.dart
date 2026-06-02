import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../constants.dart';

class ShowPdfPage extends StatelessWidget {
  final String pdfUrl;
  ShowPdfPage({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Sarkari Era",
            style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 24.sp)),
      ),
      body: SfPdfViewer.network(
        "${pdfUrl}",
      ),
    );
  }
}
