#!/usr/bin/env bash
# Builds the offline Android APK. Needs: Node 18+, Java 17, Android SDK (the GitHub workflow has all of these).
set -e
npm install
mkdir -p www/engine
cp src/index.html www/index.html
cp node_modules/chess.js/chess.js www/chess.js
JS=$(ls node_modules/stockfish/src/*lite-single*.js node_modules/stockfish/bin/*lite-single*.js 2>/dev/null | head -1 || true)
if [ -z "$JS" ]; then echo "Stockfish lite-single build not found. Inspect node_modules/stockfish and adjust prepare.sh"; exit 1; fi
cp "${JS%.js}".* www/engine/
NAME=$(basename "$JS")
sed -i "s/__SF_JS__/$NAME/" www/index.html
echo "Bundled engine file: $NAME"
echo "stockfish npm package version: $(node -p "require('./node_modules/stockfish/package.json').version")"
[ -d android ] || npx cap add android
npx cap sync android
M=android/app/src/main/AndroidManifest.xml
sed -i '/android.permission.INTERNET/d' "$M"            # fully offline: no network permission
sed -i 's/android:allowBackup="true"/android:allowBackup="false"/' "$M"
(cd android && chmod +x gradlew && ./gradlew assembleDebug)
echo "APK: android/app/build/outputs/apk/debug/app-debug.apk"
