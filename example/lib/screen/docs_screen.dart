import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


String file = "home.md";

class DocsScreen extends StatefulWidget {
  DocsScreen({Key key}) : super(key: key);

  @override
  _DocsScreenState createState() => _DocsScreenState();
}

class _DocsScreenState extends State<DocsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(getFile()),),
        body: displayMarkdown(getFile())
    );
  }
  FutureBuilder<String> displayMarkdown(String file){

    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString
        ("assets/docs/" + file),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        if (snapshot.hasData) {
          return Markdown(
            data: snapshot.data,
            onTapLink: (text,link,title){
              if(!link.endsWith('.md')) {
                link = link + '.md';
              }


              if(link.startsWith('md://')) {
                link = link.substring('md://'.length);
              }

              setFile(link);
              setState((){});
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

String getFile() {
  return file;
}

String setFile(String name) {
  file = name;
  return file;
}