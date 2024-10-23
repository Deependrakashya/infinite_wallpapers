import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setwallpaper extends StatelessWidget {
  final String imgUrl;
  const Setwallpaper({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Image.network(
            height: double.infinity,
            width: double.infinity,
            imgUrl,
            fit: BoxFit.cover,
          ),
          Positioned(
              // left: 10,
              child: IconButton(
                  splashColor: Colors.amber,
                  // style: ButtonStyle(
                  //     backgroundColor: WidgetStatePropertyAll(
                  //         const Color.fromARGB(255, 192, 192, 192))

                  //         )

                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    CupertinoIcons.back,
                    color: Colors.yellow,
                    size: 30,
                  ))),
        ],
      ),
    );
  }
}
