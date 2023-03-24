import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class CryptoApp extends StatefulWidget {
  const CryptoApp({super.key});

  @override
  State<CryptoApp> createState() => _CryptoAppState();
}

class _CryptoAppState extends State<CryptoApp> {
  final channel = IOWebSocketChannel.connect(
    'wss://stream.binance.com:9443/ws/btcusdt@trade',
        );
  String btcUsdtPrice = '0';
  @override
  void initState() {
    super.initState();
    streamListener();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crypto Nation'),
        ),
        body: Center(
          child: Text(
            btcUsdtPrice,
          ),
        ),
      ),
    );
  }

  streamListener() {
    channel.stream.listen((message) {
      Map getData = jsonDecode(message);
      setState(() {
        btcUsdtPrice = getData['p'];
      });
    });
  }
}
