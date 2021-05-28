
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';

class LoadingHub {
  static LoadingHub _instance = new LoadingHub.internal();
  static bool _isLoading = false;
  static BuildContext _context;
  
  LoadingHub.internal();
  factory LoadingHub() => _instance;
  
  static void closeLoadingDialog() {
    if (_isLoading) {
      Navigator.of(_context).pop();
      _isLoading = false;
    }
  }

  static void showLoadingDialog(BuildContext context) async {
    _context = context;
    _isLoading = true;
    await showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(GoloColors.primary),
                ),
              )
            ],
          );
        });
  }

}
