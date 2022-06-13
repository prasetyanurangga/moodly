import 'package:flutter/material.dart';

class NotFoundPage extends StatefulWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _buildMain(){
    return Scaffold(
      body: Container()
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }
}
