# ImageRandomizer

[![IDE](https://img.shields.io/badge/Xcode-15.2-blue.svg)](https://developer.apple.com/xcode/)
[![Language](https://img.shields.io/badge/swift-5.9-orange.svg)](https://swift.org)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%2515.2-green.svg)](https://developer.apple.com/ios/)

### Описание
Отображает рандомное изображение.

### Функционал
- При первом запуске приложения отображается изображение по умолчанию.
- При нажатии на кнопку отображается рандомное изображение.
- Можно увеличить изображение на весь экран нажав на само изображение.

- Работа с кэшем:
    - Сохраняет изображение в кэш после закрытия приложения;
    - Загружает изображение из кэша, если оно там есть;
    - Очищает кэш, если между запусками приложения прошло больше 5 минут.
