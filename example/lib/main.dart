import 'package:flutter/material.dart';
import 'package:hk_flutter/hk_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '海康摄像头测试',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '海康摄像头测试'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _hkFlutter = HkFlutter();
  final _logs = <String>[];
  final _ipController = TextEditingController(text: '192.168.1.64');
  final _portController = TextEditingController(text: '8000');
  final _userNameController = TextEditingController(text: 'admin');
  final _passwordController = TextEditingController(text: 'admin12345');

  void _addLog(String log, {bool isError = false}) {
    setState(() {
      final timestamp = DateTime.now().toString().split('.').first;
      final prefix = isError ? '[错误] ' : '[信息] ';
      final logMessage = '$timestamp $prefix$log';
      _logs.insert(0, logMessage);
      // 同时打印到控制台
      print(logMessage);
    });
  }

  Future<void> _initCamera() async {
    try {
      _addLog('开始初始化摄像头...');
      _addLog('参数: IP=${_ipController.text}, 端口=${_portController.text}, 用户名=${_userNameController.text}');
      final result = await _hkFlutter.initCamera(
        ip: _ipController.text,
        port: _portController.text,
        userName: _userNameController.text,
        password: _passwordController.text,
      );
      _addLog('初始化摄像头结果: $result');
    } catch (e) {
      _addLog('初始化摄像头失败: $e', isError: true);
    }
  }

  Future<void> _setVideoInfo() async {
    try {
      _addLog('开始设置视频信息...');
      final result = await _hkFlutter.setVideoInfo();
      _addLog('设置视频信息结果: $result');
    } catch (e) {
      _addLog('设置视频信息失败: $e', isError: true);
    }
  }

  Future<void> _setOSDInfo() async {
    try {
      _addLog('开始设置OSD信息...');
      final result = await _hkFlutter.setOSDInfo();
      _addLog('设置OSD信息结果: $result');
    } catch (e) {
      _addLog('设置OSD信息失败: $e', isError: true);
    }
  }

  Future<void> _setNtp() async {
    try {
      _addLog('开始设置NTP...');
      final result = await _hkFlutter.setNtp();
      _addLog('设置NTP结果: $result');
    } catch (e) {
      _addLog('设置NTP失败: $e', isError: true);
    }
  }

  Future<void> _setTime() async {
    try {
      _addLog('开始设置时间...');
      final result = await _hkFlutter.setTime();
      _addLog('设置时间结果: $result');
    } catch (e) {
      _addLog('设置时间失败: $e', isError: true);
    }
  }

  Future<void> _setPwd() async {
    try {
      _addLog('开始设置密码...');
      _addLog('参数: 用户名=${_userNameController.text}');
      final result = await _hkFlutter.setPwd(
        userName: _userNameController.text,
        pwd: _passwordController.text,
      );
      _addLog('设置密码结果: $result');
    } catch (e) {
      _addLog('设置密码失败: $e', isError: true);
    }
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: _clearLogs,
            tooltip: '清除日志',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(labelText: 'IP地址'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _portController,
              decoration: const InputDecoration(labelText: '端口'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: '用户名'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: '密码'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _initCamera,
                  child: const Text('初始化摄像头'),
                ),
                ElevatedButton(
                  onPressed: _setVideoInfo,
                  child: const Text('设置视频信息'),
                ),
                ElevatedButton(
                  onPressed: _setOSDInfo,
                  child: const Text('设置OSD信息'),
                ),
                ElevatedButton(
                  onPressed: _setNtp,
                  child: const Text('设置NTP'),
                ),
                ElevatedButton(
                  onPressed: _setTime,
                  child: const Text('设置时间'),
                ),
                ElevatedButton(
                  onPressed: _setPwd,
                  child: const Text('设置密码'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('日志输出：', style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Text('共 ${_logs.length} 条日志'),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ListView.builder(
                  reverse: true,
                  itemCount: _logs.length,
                  itemBuilder: (context, index) {
                    final log = _logs[index];
                    final isError = log.contains('[错误]');
                    return Text(
                      log,
                      style: TextStyle(
                        color: isError ? Colors.red : Colors.black,
                        fontSize: 12,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
