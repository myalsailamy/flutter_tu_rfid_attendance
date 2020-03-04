import 'package:flutter/material.dart';

// رابط خدمة ال api الأساسية و جعلناه متغير ثابت، من أجل عدم كتابته كل مره أردنا كتابة رابط ال api
const ApiURL = "http://bertslal-001-site17.atempurl.com/api";
//const ApiURL = "http://10.0.2.2/api";

// لإلغاء العملية بعد الانتهاء من تنفيذ الإجراء
//if (model.data.hasAccess == 0) { Navigator.pop(context); }
class AppUtils {
  // تظهر لنا مربع يطلب مننا الانتظار حتى يتم الاضافة شيء أو تحميل بيانات ما
  static showProgressDialog(BuildContext context, String title) {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Flexible(
                      flex: 8,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            );
          });
    } catch (e) {
      print(e.toString());
    }
  }

  // الكود الذي يقوم باظهار الرسائل التي تظهر أسفل الشاشة
  static void showSnackBar(
      {String message, BuildContext context, Color color = Colors.black54}) {
    final snackBar = SnackBar(
      backgroundColor: color,
      duration: Duration(seconds: 3),
      content: Container(
          height: 80.0,
          child: Center(
            child: Text(
              message,
              style: TextStyle(fontSize: 25.0),
            ),
          )),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
