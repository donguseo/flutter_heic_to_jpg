# heic_to_jpg

With this plugin you can convert HEIC/HEIF file to JPEG image easily

## Installation
Add the Package
```yaml
dependencies:
  heic_to_jpg: ^0.1.3
```

## How to use

Import the package in your dart file

```dart
import 'package:heic_to_jpg/heic_to_jpg.dart';
```

And call convert method with local HEIC/HEIF image file path.
```dart
String jpegPath = await HeicToJpg.convert(heicPath);
```