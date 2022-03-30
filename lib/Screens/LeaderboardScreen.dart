import 'package:flutter/material.dart';
import 'package:tik_toe/Widgets/AppText.dart';
import 'package:tik_toe/Widgets/Styles.dart';
import 'package:tik_toe/Widgets/WinningPlayer.dart';



class LeaderBoard extends StatelessWidget {
  List<WinningPlayer> playerList = [];
  LeaderBoard({Key? key, required this.playerList}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 25, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const ImageIcon(AssetImage("assets/images/back.png"),
                          size: 30, color: Colors.black),
                    ),
                    const SizedBox(width: 30),
                    const AppText(
                        text: "LEADER",
                        color: appDarkBlue,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 8,
                        height: 1),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 63),
                child: AppText(
                    text: "BOARD",
                    color: appDarkBlue,
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 12,
                    height: 1.25),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: cards,
                    itemCount: playerList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 5)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cards(BuildContext context, int index) => Card(
    color: appCardColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    shadowColor: Colors.white,
    child: Container(
      margin:
      const EdgeInsets.only(left: 34, top: 25, bottom: 23, right: 21),
      child: Row(
        children: [
          Image.asset(
              "assets/images/${playerList[index].player == 2 ? "X" : "O"}.png",
              color: playerList[index].player == 2
                  ? appDarkBlue
                  : appLightBlue,
              height: 30,
              width: 30),
          const SizedBox(width: 23),
          AppText(
              text: "Player ${playerList[index].player}",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 1),
          const Spacer(),
          Image.asset('assets/images/trophy.png', height: 52, width: 52)
        ],
      ),
    ),
  );
}