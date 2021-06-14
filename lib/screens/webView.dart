import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {

  final String lien;

  WebViewScreen(this.lien);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewScreen> {

  String lien;
  bool isLoading=true;

  final _key = UniqueKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    lien = widget.lien;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      backgroundColor: Colors.black38,
      title: Text('Inscription'),
      leading:  IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          }
      ),
      // actions

    ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: lien,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
        ],
      ),

    );
  }
}
