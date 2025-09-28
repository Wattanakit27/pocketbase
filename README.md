# CRUD PocketBase with Flutter

## Git workflow
- `git checkout -b crudpocketbase`
- ลบไฟล์ทั้งหมด เหลือ `readme.md`
- commit + push

## PocketBase
- ดาวน์โหลด [pocketbase.io](https://pocketbase.io)
- รัน `./pocketbase serve`
- Admin UI: http://127.0.0.1:8090/_/
- Collection:
  - users (auth)
  - character (fields: name, role, power)

## Flutter
- สร้างโปรเจกต์: `flutter create .`
- ติดตั้ง:
  ```yaml
  dependencies:
    flutter:
      sdk: flutter
    pocketbase: any
    provider: any

run
flutter run -d chrome
