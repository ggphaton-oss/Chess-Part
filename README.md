# Chess Park – offline Android app
Build without installing anything (works from a phone browser):
1. Create a free GitHub account and a new private repository.
2. Upload every file in this folder (keep `.github/workflows/build.yml` and `src/index.html` in place).
3. Open the Actions tab → "Build APK" → Run workflow. When it finishes, download the `chess-park-apk` artifact, unzip it, and install `app-debug.apk`
   (Android will ask you to allow installs from your browser/files app).
4. In the build log, check the line "stockfish npm package version" and confirm it is the Stockfish 19 build.

The app has no network permission and everything (engine, chess library, UI) is bundled in the APK.
Note: Stockfish is GPLv3; keep its license if you share the APK.
