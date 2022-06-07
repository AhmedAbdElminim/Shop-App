import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget MyDivider() => Container(
      color: Colors.grey,
      width: double.infinity,
      height: 1,
    );
void navigateAndFinish({required context, required widget}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );
void showToAst({required String msg, required bool iserror}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: iserror ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);

Future defaultShowDialog(context) => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Choose option',
          style: TextStyle(color: Colors.purple),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).splashColor,
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Camera',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).splashColor,
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Gallery',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context).splashColor,
                onTap: () {},
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.remove,
                          size: 15,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Remove',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
Future referanceshowdialog(context) => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Choose option'),
        content: const Text('AlertDialog description'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
