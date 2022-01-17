import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  /// 上下联横批动画控制器
  late AnimationController _downAnimationController;
  late AnimationController _upAnimationController;
  late AnimationController _horizontalAnimationController;

  bool _showFu = false;

  /// 存储上下联 横批的数据集合
  final List _downList = [];
  final List _upList = [];
  final List _horizontalList = [];

  /// 随机数生成 每次随机显示数据中的对联
  int randomNum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _downList
      ..add("红梅含苞傲冬雪")
      ..add("事事如意大吉祥")
      ..add("春满人间欢歌阵阵")
      ..add("春临大地百花艳")
      ..add("福星高照全家福");
    _upList
      ..add("绿柳吐絮迎新春")
      ..add("家家顺心永安康")
      ..add("福临门第喜气洋洋")
      ..add("节至人间万象新")
      ..add("春光耀辉满堂春");
    _horizontalList
      ..add("欢度春节")
      ..add("四季兴隆")
      ..add("五福四海")
      ..add("万事如意")
      ..add("春意盎然");
    randomNum = Random().nextInt(5);
    print("随机数:$randomNum");
    _downAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _downAnimationController.addListener(() {
      // 下联动画完成开始横批动画
      if (_downAnimationController.isCompleted) {
        _horizontalAnimationController.forward();
      }
      setState(() {});
    });

    _upAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _upAnimationController.addListener(() {
      // 上联动画完成开始下联动画
      if (_upAnimationController.isCompleted) {
        _downAnimationController.forward();
      }
      setState(() {});
    });
    _upAnimationController.forward();

    _horizontalAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _horizontalAnimationController.addListener(() {
      // 横批动画完成开始显示福字
      if (_horizontalAnimationController.isCompleted) {
        _showFu = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Container(
            width: _horizontalAnimationController.value * 240,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: const Color(0xffc62c21),
            child: Text(_horizontalList[randomNum],
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "kaiti",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const SizedBox(
                width: 50,
              ),
              Container(
                width: 70,
                height: _downAnimationController.value * 420,
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                color: const Color(0xffc62c21),
                child: Text(
                  _downList[randomNum],
                  maxLines: 999,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "kaiti",
                      height: 1.5,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _showFu ? 1 : 0,
                child: Image.asset(
                  "assets/images/fu.png",
                  width: 120,
                  height: 120,
                ),
              ),
              const Spacer(),
              Container(
                width: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: _upAnimationController.value * 420,
                alignment: Alignment.center,
                color: const Color(0xffc62c21),
                child: Text(
                  _upList[randomNum],
                  maxLines: 999,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      height: 1.5,
                      fontFamily: "kaiti",
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: _showFu ? 1 : 0,
            child: Image.asset(
              "assets/images/2022.gif",
              width: 230,
              height: 230,
            ),
          )
        ],
      ),
    );
  }
}
