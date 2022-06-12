# environment_separation_sample
Firestoreの環境を分けた場合の挙動確認サンプルアプリ。
個人アプリ規模で使用する想定で、開発環境と本番環境の2つだけ分ける。

## Getting Started
# Firestore
本番用と開発用の2つを準備する(立ち上げる)

# ios: 
以下のフォルダ配下にgoogle-servicesファイルを追加(語尾修正)
ios/Runner/GoogleService-info-dev.plist
ios/Runner/GoogleService-info-release.plist
xcodeを開いて、Runner/Build Phases/Run Script/のShellスクリプトを環境分け用のものに上書き

# Android
以下のフォルダ配下にgoogle-servicesファイルを追加
android/app/src/debug/google-services.json
android/app/src/release/google-services.json