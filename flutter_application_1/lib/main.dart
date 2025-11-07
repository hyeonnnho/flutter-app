// 1. Flutter의 디자인(Material) 라이브러리를 가져옵니다.
import 'package:flutter/material.dart';

// 2. 앱을 시작하는 main 함수입니다.
void main() {
  runApp(const MyApp());
}

// 3. 'MyApp'이라는 이름의 위젯을 만듭니다.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 4. 'MaterialApp'은 앱 전체를 감싸는 뼈대입니다.
    return MaterialApp(
      home: Scaffold(
        // 5. 'AppBar'는 앱의 상단에 있는 파란색 바입니다.
        appBar: AppBar(
          title: const Text('나의 첫 앱'),
          backgroundColor: Colors.blue,
        ),
        // 6. 'body'는 앱의 실제 내용이 들어갈 부분입니다.
        body: Center(
          // 2. [변경] Center의 자식이 Column으로 바뀜
          child: Column(
            // 3. [추가] Column의 자식들을 세로축(Y)에서도 중앙에 오도록 정렬
            mainAxisAlignment: MainAxisAlignment.center,

            // 4. [변경] 'child:'가 'children: []' (목록)으로 바뀜
            children: <Widget>[
              // 5. Column의 첫 번째 자식: 우리가 만든 박스
              Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  '안녕하세요, Flutter!',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // 6. [추가] 박스와 버튼 사이에 '간격'을 주는 빈 박스
              const SizedBox(height: 30),

              // 7. [추가] Column의 두 번째 자식: 클릭 가능한 버튼
              ElevatedButton(
                // 8. [필수] 버튼을 '눌렀을 때' 실행될 동작
                onPressed: () {
                  // 이 코드가 실행되면 VS Code의 'DEBUG CONSOLE'에 글자가 찍힘
                  print('버튼이 클릭되었습니다!');
                },
                // 9. 버튼에 표시될 글자
                child: const Text('눌러보세요!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
