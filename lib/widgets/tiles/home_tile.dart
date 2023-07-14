import 'package:flutter/material.dart';

import '../cab_text.dart';

class HomeTile extends StatefulWidget {
  final Map tileData;
  final Map countMap;
  const HomeTile({Key? key, required this.tileData, required this.countMap})
      : super(key: key);

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  double scale = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: MouseRegion(
        //  cursor: SystemMouseCursors.click,
        onEnter: (_) {
          scale = -10;
          setState(() {});
        },
        onExit: (_) {
          scale = 0;
          setState(() {});
        },
        child: Transform(
          transform: Matrix4.translationValues(0, scale, 0),
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(widget.tileData["route"],
                  arguments: widget.tileData["name"] == "Bookings"
                      ? {"role": "", "name": "", "id": ""}
                      : null);
            },
            mouseCursor: SystemMouseCursors.click,
            minVerticalPadding: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            tileColor: widget.tileData['color'],
            trailing: Container(
              width: 100,
              transform: Matrix4.translationValues(0, -10, 0),
              child: Icon(widget.tileData["icon"],
                  size: 150, color: Colors.white54),
            ),
            title: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CabText(
                      widget.tileData["name"] == "Notification"
                          ? "Send"
                          : "${widget.countMap[widget.tileData["name"].toString().toLowerCase()] ?? ""}",
                      color: Colors.white,
                      size: 40,
                      weight: FontWeight.w100,
                    ),
                    Row(
                      children: [
                        CabText(
                          widget.tileData["name"],
                          color: Colors.white,
                          size: 36,
                          weight: FontWeight.w100,
                        ),
                        const SizedBox(width: 10),
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Icon(Icons.arrow_forward_ios_rounded,
                              size: 30, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
