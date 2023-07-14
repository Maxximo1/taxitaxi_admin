// import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../widgets/cab_text.dart';

Future getImageFromGallery() async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  // var image = await FilePickerWeb.platform
  //     .pickFiles(allowedExtensions: ['jpg', 'png'], allowMultiple: false);
  //     image.files[0].
  return image;
}

String formatNumber(num value) {
  var formatter = NumberFormat('#,##,#00');
  return formatter.format(value);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase().replaceAll("*", '')}";
  }
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2)}.${parts[1].padLeft(2, '0')}';
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return const TextEditingValue().copyWith(text: min.toStringAsFixed(0));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}

showSnack(
    {required BuildContext context,
    required String message,
    Color? color,
    double? margin}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: margin ?? 30, left: 20, right: 20),
    content: CabText(
      message,
      size: 14,
      color: Colors.white,
    ),
    backgroundColor: color ?? const Color(0xFF080808),
  ));
}
