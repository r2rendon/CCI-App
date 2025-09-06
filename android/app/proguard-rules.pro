# ProGuard rules for Flutter
# Mantén las clases de Flutter y plugins
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.** { *; }
-dontwarn io.flutter.embedding.engine.FlutterEngine
# Mantén clases de Lottie
-keep class com.airbnb.lottie.** { *; }
-keep class com.airbnb.lottie.parser.** { *; }
-keep class com.airbnb.lottie.model.** { *; }
-keep class com.airbnb.lottie.value.** { *; } 
# Flutter Play Core SplitCompat
-keep class com.google.android.play.** { *; }
-keep class com.google.android.play.core.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; } 