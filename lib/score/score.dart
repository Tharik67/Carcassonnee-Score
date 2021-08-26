import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:points_carcassone/extra_icons_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home.dart';

class Score extends StatefulWidget {
  final bool black;
  final bool red;
  final bool blue;
  final bool green;
  final bool yellow;
  final bool pink;

  const Score(
      {Key key,
      this.black,
      this.red,
      this.blue,
      this.green,
      this.yellow,
      this.pink})
      : super(key: key);
  @override
  _ScoreState createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  int _pontosblack = 0;
  int _pontosred = 0;
  int _pontosblue = 0;
  int _pontosgreen = 0;
  int _pontosyellow = 0;
  int _pontospink = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  //Loading counter value on start
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pontosblack = (prefs.getInt('pontosblack') ?? 0);
      _pontosred = (prefs.getInt('pontosred') ?? 0);
      _pontosyellow = (prefs.getInt('pontosyellow') ?? 0);
      _pontosblue = (prefs.getInt('pontosblue') ?? 0);
      _pontosgreen = (prefs.getInt('pontosgreen') ?? 0);
      _pontospink = (prefs.getInt('pontospink') ?? 0);
    });
  }

  _restart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('black', false);
      prefs.setBool('red', false);
      prefs.setBool('yellow', false);
      prefs.setBool('blue', false);
      prefs.setBool('green', false);
      prefs.setBool('pink', false);
      prefs.setInt('pontosblack', 0);
      prefs.setInt('pontosred', 0);
      prefs.setInt('pontosyellow', 0);
      prefs.setInt('pontosblue', 0);
      prefs.setInt('pontosgreen', 0);
      prefs.setInt('pontospink', 0);
    });
  }

  _increment(cor, number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (cor) {
      case "black":
        setState(() {
          _pontosblack += number;
          prefs.setInt('pontosblack', _pontosblack);
        });
        break;
      case "red":
        setState(() {
          _pontosred += number;
          prefs.setInt('pontosred', _pontosred);
        });
        break;
      case "yellow":
        setState(() {
          _pontosyellow += number;
          prefs.setInt('pontosyellow', _pontosyellow);
        });
        break;
      case "blue":
        setState(() {
          _pontosblue += number;
          prefs.setInt('pontosblue', _pontosblue);
        });
        break;
      case "green":
        setState(() {
          _pontosgreen += number;
          prefs.setInt('pontosgreen', _pontosgreen);
        });
        break;
      case "pink":
        setState(() {
          _pontospink += number;
          prefs.setInt('pontospink', _pontospink);
        });
        break;
    }
  }

  _decrement(cor, number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (cor) {
      case "black":
        setState(() {
          _pontosblack -= number;
          prefs.setInt('pontosblack', _pontosblack);
        });
        break;
      case "red":
        setState(() {
          _pontosred -= number;
          prefs.setInt('pontosred', _pontosred);
        });
        break;
      case "yellow":
        setState(() {
          _pontosyellow -= number;
          prefs.setInt('pontosyellow', _pontosyellow);
        });
        break;
      case "blue":
        setState(() {
          _pontosblue -= number;
          prefs.setInt('pontosblue', _pontosblue);
        });
        break;
      case "green":
        setState(() {
          _pontosgreen -= number;
          prefs.setInt('pontosgreen', _pontosgreen);
        });
        break;
      case "pink":
        setState(() {
          _pontospink -= number;
          prefs.setInt('pontospink', _pontospink);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBarScore(), body: _listajogadoresScore());
  }

  Widget _listajogadoresScore() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/background.jpg"),
        fit: BoxFit.cover,
      )),
      child: ListView(
        children: <Widget>[
          _cardJogadorScore(widget.red, _pontosred, 'red', Colors.red),
          _cardJogadorScore(widget.black, _pontosblack, 'black', Colors.black),
          _cardJogadorScore(widget.blue, _pontosblue, 'blue', Colors.blue),
          _cardJogadorScore(
              widget.yellow, _pontosyellow, 'yellow', Colors.yellow),
          _cardJogadorScore(widget.green, _pontosgreen, 'green', Colors.green),
          _cardJogadorScore(widget.pink, _pontospink, 'pink', Colors.pink[200]),
        ],
      ),
    );
  }

  Widget _cardJogadorScore(teste, _pontos, cor, color) {
    if (teste) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          color: Colors.black12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _botaojogadorScore(cor, 10, 'sub'),
              _botaojogadorScore(cor, 1, 'sub'),
              _pontuacaoJogadorScore(_pontos, color),
              _botaojogadorScore(cor, 1, 'plus'),
              _botaojogadorScore(cor, 10, 'plus'),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }

  Widget _pontuacaoJogadorScore(pontos, color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      child: Column(
        children: <Widget>[
          _iconJogadorScore(color),
          _pontosScore(pontos),
        ],
      ),
    );
  }

  Widget _iconJogadorScore(color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.5),
      child: Icon(
        ExtraIcons.boneco,
        size: 40,
        color: color,
      ),
    );
  }

  Widget _botaojogadorScore(_pontos, number, i) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.5),
      width: MediaQuery.of(context).size.width / 6,
      height: 60,
      child: RaisedButton(
        onPressed: () => i == 'sub'
            ? _decrement(_pontos, number)
            : _increment(_pontos, number),
        child: i == 'sub'
            ? Text('- $number',
                style: TextStyle(
                  fontSize: 12,
                ))
            : Text('+ $number',
                style: TextStyle(
                  fontSize: 12,
                )),
      ),
    );
  }

  Widget _pontosScore(_pontos) {
    return Text(
      '$_pontos',
      style: TextStyle(fontSize: 25, color: Colors.white),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Restart"),
          content: new Text("Deseja comecar uma nova partida?"),
          actions: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: new FlatButton(
                  color: Colors.deepPurple,
                  child: new Text("Nao"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: new FlatButton(
                    color: Colors.deepOrange,
                    child: new Text("Sim"),
                    onPressed: () async {
                      await _restart();
                      await Navigator.pushReplacement(context,
                          CupertinoPageRoute(builder: (context) => Home()));
                    })),
          ],
        );
      },
    );
  }

  Widget _appBarScore() {
    return AppBar(
      actions: <Widget>[
        RaisedButton(
          color: Color.fromARGB(255, 181, 47, 144),
          onPressed: _showDialog,
          child: Row(
            children: <Widget>[
              Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Colors.red, Colors.purple])),
      ),
      title: Text("Score"),
    );
  }
}
