import 'package:flutter/material.dart';
import 'package:tik_toe/Widgets/AppText.dart';
import 'package:tik_toe/Widgets/GameBoard.dart';
import 'package:tik_toe/Widgets/Styles.dart';
import 'package:tik_toe/Widgets/WinningPlayer.dart';

import 'LeaderboardScreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<int>> _gameGrid = [
    [-1, -1, -1],
    [-1, -1, -1],
    [-1, -1, -1]
  ];

  int playerTurn = 0;
  var player_image = "O.png";
  var playerWonBy = 0;

  bool gameOver = false;
  bool _navigateScreen = false;
  List<WinningPlayer> players = [];

  navigateScreen() async {
    await Future.delayed(const Duration(milliseconds: 500))
        .then((value) => setState((){
      _navigateScreen = true;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          // padding: const EdgeInsets.only(left: 61, top: 71, right: 60),
          padding: const EdgeInsets.only(left: 30, top: 71, right: 29),
          child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(22),
                    width: 91,
                    height: 91,
                    decoration: BoxDecoration(
                        color: appLightBlue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: playerTurn == 0
                            ? [
                          BoxShadow(
                              offset: const Offset(0.0, 20.0),
                              blurRadius: 22,
                              color: appLightBlue.withOpacity(0.5))
                        ]
                            : []),
                    child: SizedBox(
                      width: 47,
                      height: 47,
                      child: Image.asset(
                        "assets/images/O.png",
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                    )),
                const SizedBox(width: 28),
                const AppText(
                  text: "VS",
                  color: appFirstTextColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(width: 18),
                Container(
                    padding: const EdgeInsets.all(22),
                    width: 91,
                    height: 91,
                    decoration: BoxDecoration(
                        color: appDarkBlue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: playerTurn == 1
                            ? [
                          BoxShadow(
                              offset: const Offset(0.0, 20.0),
                              blurRadius: 16,
                              color: appDarkBlue.withOpacity(0.5))
                        ]
                            : []),
                    child: SizedBox(
                      width: 47,
                      height: 47,
                      child: Image.asset(
                        "assets/images/X.png",
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AppText(
                    text: "Player 1",
                    color: appSecondTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1),
                SizedBox(width: 70),
                AppText(
                  text: "Player 2",
                  color: appSecondTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ],
            ),
            const SizedBox(height: 80),
            Visibility(
              visible: !_navigateScreen,
              child: Expanded(
                flex: 3,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: _gameGrid
                        .asMap()
                        .entries
                        .map((row) => Expanded(
                      child: Row(
                        children: row.value
                            .asMap()
                            .entries
                            .map((col) => Expanded(
                          child: InkWell(
                            onTap: () {
                              if (col.value < 0) {
                                setState(() {
                                  _gameGrid[row.key]
                                  [col.key] = playerTurn;
                                  playerTurn =
                                  playerTurn == 0 ? 1 : 0;
                                  gameOver = _isGameOver();
                                  if (gameOver == true) {
                                    players.add(WinningPlayer(
                                        playerWonBy));
                                    navigateScreen();
                                  }
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: GameBoardBorder()
                                      .borderDetect(
                                      col.key, row.key)),
                              //
                              child: col.value < 0
                                  ? const SizedBox.shrink()
                                  : Container(
                                width: 58,
                                height: 58,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            col.value ==
                                                0
                                                ? "assets/images/O.png"
                                                : "assets/images/X.png"),
                                        fit: BoxFit
                                            .contain),
                                    boxShadow: [
                                      col.value == 0
                                          ? BoxShadow(
                                          offset: const Offset(
                                              0.0,
                                              20.0),
                                          blurRadius:
                                          22,
                                          color: appLightBlue
                                              .withOpacity(
                                              0.2))
                                          : BoxShadow(
                                          offset: const Offset(
                                              0.0,
                                              20.0),
                                          blurRadius:
                                          16,
                                          color: appDarkBlue
                                              .withOpacity(
                                              0.2))
                                    ]),
                              ),
                            ),
                          ),
                        ))
                            .toList(),
                      ),
                    ))
                        .toList(),
                  ),
                ),
              ),
            ),
            Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 422,
                      decoration: BoxDecoration(
                        color: appDarkBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 212,
                              height: 212,
                              child: Image.asset("assets/images/trophy.png",
                                  fit: BoxFit.contain)),
                          const SizedBox(height: 28),
                          Text("Player $playerWonBy",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal)),
                          const SizedBox(height: 5),
                          const Text("WON",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal))
                        ],
                      ),
                    )
                  ],
                ),
                visible: _navigateScreen),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 43),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 62,
                    width: 218,
                    decoration: BoxDecoration(
                        color: appDarkBlue,
                        borderRadius: BorderRadius.circular(100)),
                    child: GestureDetector(
                      onTap: () {
                        var data = players;
                        Navigator.of(context)
                            .push<WinningPlayer>(MaterialPageRoute(
                            builder: (_) =>
                                LeaderBoard(playerList: players)))
                            .then((value) => reset());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/menu.png",
                              width: 23, height: 20),
                          const SizedBox(width: 17),
                          const AppText(
                              text: "Leader board",
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.5)
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Image.asset("assets/images/refresh.png",
                        width: 39, height: 40),
                    onTap: () {
                      setState(() {
                        _gameGrid = [
                          [-1, -1, -1],
                          [-1, -1, -1],
                          [-1, -1, -1]
                        ];

                        playerTurn = 0;
                        player_image = "O.png";
                        playerWonBy = 0;
                        gameOver = false;
                        _navigateScreen = false;
                      });
                    },
                  )
                ],
              ),
            )
          ]),
        ));
  }

  reset() {
    setState(() {
      _gameGrid = [
        [-1, -1, -1],
        [-1, -1, -1],
        [-1, -1, -1]
      ];

      playerTurn = 0;
      player_image = "O.png";
      playerWonBy = 0;
      gameOver = false;
      _navigateScreen = false;
    });
  }

  bool _isGameOver() {
    //rows check
    for (var i = 0; i < _gameGrid.length; i++) {
      int countPos = 0;
      for (var j = 0; j < _gameGrid[i].length; j++) {
        if (_gameGrid[i][j] != -1) {
          countPos++;
        }
      }
      if (countPos == 3) {
        var rowsCheck =
        _gameGrid[i].reduce((value1, value2) => value1 + value2);
        if (rowsCheck == 3 || rowsCheck == 0) {
          playerWonBy = _wonBy(rowsCheck);
          return true;
        }
      }
    }

    //col check
    List<int> colValue = [0, 0, 0];
    for (var i = 0; i < _gameGrid.length; i++) {
      for (var j = 0; j < _gameGrid[i].length; j++) {
        colValue[j] += _gameGrid[i][j];
        if (i == 2 && (colValue[j] == 3 || colValue[j] == 0)) {
          var rows = _gameGrid.map((row) => row[j]);
          var colCheck = rows.every((element) => element != -1);
          if (colCheck == true) {
            playerWonBy = _wonBy(colValue[j]);
            return true;
          }
        }
      }
    }

    //diagonal check
    diagonalCheck({reverse = false}) {
      var diagonalCheck = (reverse ? _gameGrid.reversed.toList() : _gameGrid)
          .asMap()
          .entries
          .map((row) => row.value[row.key]);

      if (diagonalCheck.every((element) => element != -1) == true) {
        var diagonalResult =
        diagonalCheck.reduce((value1, value2) => value1 + value2);
        return diagonalResult;
      }
    }
    var rtolDiagonalCheck = diagonalCheck();
    var ltorDiagonalCheck = diagonalCheck(reverse: true);

    if (rtolDiagonalCheck == 0 || rtolDiagonalCheck == 3 || ltorDiagonalCheck == 0 || ltorDiagonalCheck == 3) {
      var diagonaResult =
      rtolDiagonalCheck == null ? ltorDiagonalCheck : rtolDiagonalCheck;
      playerWonBy = _wonBy(diagonaResult!);
      return true;
    }

    return false;
  }

  _wonBy(int value) {
    return value == 3 ? 2 : 1;
  }
}