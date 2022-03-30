import 'package:flutter/material.dart';

import 'Styles.dart';


class GameBoardBorder {

  Border borderDetect(col,row){
    BorderSide _borderStyle = BorderSide(color: appGameBoardColor.withOpacity(0.4),width: 2);
    Border detect = Border.all(color: appGameBoardColor.withOpacity(0.4),width: 2);
    if(row == 0 && col == 0){
      detect = Border(
          right: _borderStyle,
          bottom: _borderStyle
      );
    }else if(row == 0 && col == 2){
      detect = Border(
          left: _borderStyle,
          bottom: _borderStyle
      );
    }else if(row == 2 && col == 0){
      detect = Border(
          right: _borderStyle,
          top: _borderStyle
      );
    }else if(row == 2 && col == 2){
      detect = Border(
          left: _borderStyle,
          top: _borderStyle
      );
    }else if(row == 1 && col == 0){
      detect = Border(
          bottom: _borderStyle,
          right:  _borderStyle,
          top: _borderStyle
      );
    }else if(row == 1 && col == 2){
      detect = Border(
          left: _borderStyle,
          bottom: _borderStyle,
          top: _borderStyle
      );
    }else if(row == 0 && col == 1){
      detect = Border(
          left: _borderStyle,
          bottom: _borderStyle,
          right: _borderStyle
      );
    }else if(row == 2 && col == 1){
      detect = Border(
          left: _borderStyle,
          right: _borderStyle,
          top: _borderStyle
      );
    }
    return detect;
  }

}