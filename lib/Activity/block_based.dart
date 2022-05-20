import 'package:flutter/cupertino.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

/// Implementation for the block-based programming GUI
class BlockBasedImplementation extends StatefulWidget {
  const BlockBasedImplementation({Key? key}) : super(key: key);

  @override
  BlockBasedImplementationState createState() {
    return BlockBasedImplementationState();
  }
}

/// State for the block-based programming GUI
class BlockBasedImplementationState extends State<BlockBasedImplementation> {
  late WebViewPlusController _controller;
  double _height = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: WebViewPlus(
        onWebViewCreated: (controller) {
          _controller = controller;
          controller.loadUrl('resources/blockly/index.html');
        },
        onPageFinished: (url) {
          _controller.getHeight().then((double height) {
            setState(() {
              _height = height;
            });
          });
        },
        javascriptMode: JavascriptMode.unrestricted,
        debuggingEnabled: true,
      ),
    );
  }
}