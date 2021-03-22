import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

void main()=>runApp(new MyApp());

//参考
//https://qiita.com/karamage/items/8d1352e5a4f1b079210b

//StateNotifierとfreezedに関する記事
//https://qiita.com/karamage/items/4b1aff984b1af7541b73

//flutter hooks と riverpod / stateNotifier を使ってカウンターアプリを実装する

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'test flutter hooks',
      debugShowCheckedModeBanner: false,
      home: ProviderScope(
        child: CounterPage(),
      ),
    );
  }
}

//ポイント
//グローバルにStateNotifierProviderを定義
final counterProvider = StateNotifierProvider((_) => Counter());


class Counter extends StateNotifier<int>{
  Counter():super(0);
  void increment()=>state++;
}


//ポイント　HookWidgetを継承
class CounterPage extends HookWidget{
  @override
  Widget build(BuildContext context) {

    //ポイント
    //状態を読み込む⇨useProvider
    final int state = useProvider(counterProvider.state);
    final counter = useProvider(counterProvider);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter hooks counter'),
      ),
      body: Center(
        child: Text(
          state.toString(),
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //state
        onPressed: ()=>counter.increment(),
      ),
    );
  }
}