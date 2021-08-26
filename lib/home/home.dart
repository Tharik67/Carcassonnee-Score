import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:points_carcassone/extra_icons_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../score/score.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _black = false;
  bool _blue = false;
  bool _red = false;
  bool _yellow = false;
  bool _green = false;
  bool _pink = false;
  bool _blackAnt = false;
  bool _blueAnt = false;
  bool _redAnt = false;
  bool _yellowAnt = false;
  bool _greenAnt = false;
  bool _pinkAnt = false;
  bool _newgame = false;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _blackAnt = (prefs.getBool('black') ?? false);
      _redAnt = (prefs.getBool('red') ?? false);
      _blueAnt = (prefs.getBool('blue') ?? false);
      _yellowAnt = (prefs.getBool('yellow') ?? false);
      _greenAnt = (prefs.getBool('green') ?? false);
      _pinkAnt = (prefs.getBool('pink') ?? false);
    });
    if (_blackAnt | _redAnt | _blueAnt | _yellowAnt | _greenAnt | _pinkAnt) {
      _newgame = true;
    } else {
      _newgame = false;
    }
  }

  _saveJogadorGameHome(continuegame) async {
    if (continuegame) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('black', _blackAnt);
      prefs.setBool('red', _redAnt);
      prefs.setBool('yellow', _yellowAnt);
      prefs.setBool('blue', _blueAnt);
      prefs.setBool('green', _greenAnt);
      prefs.setBool('pink', _pinkAnt);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('black', _black);
      prefs.setBool('red', _red);
      prefs.setBool('yellow', _yellow);
      prefs.setBool('blue', _blue);
      prefs.setBool('green', _green);
      prefs.setBool('pink', _pink);
    }
  }

  void _changeBlack(cor) {
    switch (cor) {
      case "black":
        setState(() {
          _black = !_black;
        });
        break;
      case "blue":
        setState(() {
          _blue = !_blue;
        });
        break;
      case "red":
        setState(() {
          _red = !_red;
        });
        break;
      case "yellow":
        setState(() {
          _yellow = !_yellow;
        });
        break;
      case "green":
        setState(() {
          _green = !_green;
        });
        break;
      case "pink":
        setState(() {
          _pink = !_pink;
        });
        break;
    }
  }

  //
  //Tela Incial
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: <Widget>[
              //LIST OF ICONS
              _listforHome(),
              //BUTTON PLAY GAME
              _botaoHome(),
              //BUTTON CONTINUE LAST GAME
              _botaoContinue(),
            ],
          ),
        ),
        appBar: _appBarHome('Home'));
  }

  Widget _listforHome() {
    return Column(
      children: <Widget>[
        _rowIconHome("red", _red, Colors.red),
        _rowIconHome("black", _black, Colors.black),
        _rowIconHome("blue", _blue, Colors.blue),
        _rowIconHome("yellow", _yellow, Colors.yellow),
        _rowIconHome("green", _green, Colors.green[800]),
        _rowIconHome("pink", _pink, Colors.pink[200]),
      ],
    );
  }

  Widget _iconHome(color) {
    return Icon(
      ExtraIcons.boneco,
      size: 35,
      color: color,
    );
  }

  Widget _rowIconHome(cor, isActive, color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => _changeBlack(cor),
          child: Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: isActive ? Colors.green[300] : Colors.grey,
                  borderRadius: BorderRadius.circular(10)),
              child: _iconHome(color)),
        ),
      ],
    );
  }

  Widget _botaoHome() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: RaisedButton(
        color: Colors.purple,
        disabledColor: null,
        onPressed: (_black | _red | _blue | _yellow | _green | _pink)
            ? () async {
                await _saveJogadorGameHome(false);
                await Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => Score(
                              black: _black,
                              red: _red,
                              blue: _blue,
                              yellow: _yellow,
                              green: _green,
                              pink: _pink,
                            )),
                    (route) => false);
              }
            : null,
        child: Text("New Game"),
      ),
    );
  }

  Widget _iconActiveHome(isActive, color) {
    if (isActive) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Icon(
          ExtraIcons.boneco,
          size: 18,
          color: color,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _textInContinueButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Continue:",
          textAlign: TextAlign.right,
        ),
        _iconActiveHome(_blackAnt, Colors.black),
        _iconActiveHome(_redAnt, Colors.red[900]),
        _iconActiveHome(_blueAnt, Colors.blue),
        _iconActiveHome(_yellowAnt, Colors.yellow),
        _iconActiveHome(_greenAnt, Colors.green[800]),
        _iconActiveHome(_pinkAnt, Colors.pink[200]),
      ],
    );
  }

  Widget _botaoContinue() {
    if (_newgame) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: RaisedButton(
          disabledColor: null,
          color: Colors.purple,
          onPressed: () async {
            await _saveJogadorGameHome(true);
            await Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                    builder: (context) => Score(
                          black: _blackAnt,
                          red: _redAnt,
                          blue: _blueAnt,
                          yellow: _yellowAnt,
                          green: _greenAnt,
                          pink: _pinkAnt,
                        )),
                (route) => false);
          },
          child: _textInContinueButton(),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _appBarHome(title) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.red, Colors.purple])),
      ),
    );
  }
}

/*{
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => Score()));
      }, 
      
      
      
      
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (_) => HomePage(), settings: settings);
          case 'deeper':
            return CupertinoPageRoute(
                builder: (_) => DeeperPage(), settings: settings);
        }
        */
