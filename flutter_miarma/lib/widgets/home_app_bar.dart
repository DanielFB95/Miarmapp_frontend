import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.black,
          width: 0.5,
        ))),
        margin: const EdgeInsets.only(top: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/images/logo_miarmapp.png',
              width: 100,
            ),
          ),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/newPost');
                        },
                        child: const Icon(Icons.add_box_outlined)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.send),
                  )
                ],
              ))
        ]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
