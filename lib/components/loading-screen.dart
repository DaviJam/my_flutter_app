

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingKit extends StatefulWidget {
  const LoadingKit({Key? key}) : super(key: key);

  @override
  State<LoadingKit> createState() => _LoadingKitState();
}

class _LoadingKitState extends State<LoadingKit> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: SpinKitFoldingCube(
          color: Colors.white,
          size: 100.0,
            ),
        )
      ),
    );
  }
}

