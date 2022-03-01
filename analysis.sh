flutter pub run dart_code_metrics:metrics lib --reporter=html
flutter test
flutter test --machine --coverage > tests.output
sonar-scanner -Dsonar.login="$argv[1]" -Dsonar.password="$argv[2]"