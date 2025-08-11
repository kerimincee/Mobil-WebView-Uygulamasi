import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: SplashDecider(), debugShowCheckedModeBanner: false));
}

// Uygulama açılışında kayıtlı URL kontrolü
class SplashDecider extends StatefulWidget {
  @override
  _SplashDeciderState createState() => _SplashDeciderState();
}

class _SplashDeciderState extends State<SplashDecider> {
  @override
  void initState() {
    super.initState();
    _checkSavedUrl();
  }

  Future<void> _checkSavedUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('saved_url');
    if (url != null && url.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => WebViewApp(url: url)),
      );
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => UrlInputPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

// URL giriş sayfası
class UrlInputPage extends StatefulWidget {
  @override
  _UrlInputPageState createState() => _UrlInputPageState();
}

class _UrlInputPageState extends State<UrlInputPage> {
  final TextEditingController _urlController = TextEditingController();

  bool _validateUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  Future<void> _onConnectPressed() async {
    final url = _urlController.text.trim();

    if (!_validateUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lütfen geçerli bir URL giriniz!")),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_url', url);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => WebViewApp(url: url)),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 14,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/logo.png', width: 180, height: 180),
                    const SizedBox(height: 20),
                    Text(
                      "Hoşgeldiniz",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Bağlanmak istediğiniz URL'yi giriniz",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _urlController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.link, color: Colors.deepPurple),
                        labelText: 'URL (örn: http://111.111.111.111:1111)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onConnectPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                              color: Colors.deepPurple,
                              width: 2,
                            ),
                          ),
                          elevation: 8,
                        ),
                        child: Text(
                          'Bağlan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (context) => DemoFormDialog(),
                        );
                        if (result == true) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                            'saved_url',
                            'http://213.238.182.109:1507',
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WebViewApp(
                                url: 'http://213.238.182.109:1507',
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Demo Sürümünü Al',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// WebView Sayfası
class WebViewApp extends StatefulWidget {
  final String url;
  WebViewApp({required this.url});

  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_url');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UrlInputPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.red),
            onPressed: _logout,
            tooltip: "Çıkış Yap",
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

// Demo Formu
class DemoFormDialog extends StatefulWidget {
  @override
  _DemoFormDialogState createState() => _DemoFormDialogState();
}

class _DemoFormDialogState extends State<DemoFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'firma': TextEditingController(),
    'ad': TextEditingController(),
    'soyad': TextEditingController(),
    'email': TextEditingController(),
    'telefon': TextEditingController(),
    'kullanici': TextEditingController(),
    'sifre': TextEditingController(),
  };

  Future<void> _submitDemoRequest() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:1507/demo_kayit"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'firma': _controllers['firma']!.text,
          'ad': _controllers['ad']!.text,
          'soyad': _controllers['soyad']!.text,
          'email': _controllers['email']!.text,
          'telefon': _controllers['telefon']!.text,
          'kullanici': _controllers['kullanici']!.text,
          'sifre': _controllers['sifre']!.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gönderim başarısız!")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Demo Başvuru",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ..._controllers.entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: TextFormField(
                    controller: entry.value,
                    decoration: InputDecoration(
                      labelText:
                          entry.key[0].toUpperCase() + entry.key.substring(1),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: entry.key == 'sifre',
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Zorunlu alan' : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitDemoRequest,
                child: Text("Demo Kullan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
