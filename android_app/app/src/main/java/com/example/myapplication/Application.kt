package com.example.myapplication

import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class AddFlutterApplication : FlutterApplication() {
    lateinit var flutterEngine: FlutterEngine

    companion object {
        const val FLUTTER_ENGINE_NAME = "bayu_flutter_engine_name"
    }

    override fun onCreate() {
        super.onCreate()
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_NAME, flutterEngine)
    }
}