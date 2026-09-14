class Listo < Formula
  desc "To-do list that lives as plain Markdown on disk"
  homepage "https://github.com/sergiorivas/listo"
  url "https://github.com/sergiorivas/listo/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0874403f4e7df2cf42e757c6ea413532a117d147638a143aefb9699917f5af4d"

  def install
    system "swift", "build", "-c", "release", "--product", "ListoApp"

    app = prefix/"Listo.app"
    (app/"Contents/MacOS").mkpath
    (app/"Contents/Resources").mkpath
    cp ".build/release/ListoApp", app/"Contents/MacOS/Listo"

    (app/"Contents/Info.plist").write <<~PLIST
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>CFBundleExecutable</key><string>Listo</string>
          <key>CFBundleIdentifier</key><string>com.listo.app</string>
          <key>CFBundleName</key><string>Listo</string>
          <key>CFBundleDisplayName</key><string>Listo</string>
          <key>CFBundleVersion</key><string>#{version}</string>
          <key>CFBundleShortVersionString</key><string>#{version}</string>
          <key>CFBundlePackageType</key><string>APPL</string>
          <key>LSMinimumSystemVersion</key><string>14.0</string>
          <key>NSHighResolutionCapable</key><true/>
          <key>CFBundleDocumentTypes</key>
          <array>
              <dict>
                  <key>CFBundleTypeName</key><string>Listo Markdown List</string>
                  <key>CFBundleTypeRole</key><string>Editor</string>
                  <key>LSItemContentTypes</key>
                  <array><string>net.daringfireball.markdown</string></array>
                  <key>LSHandlerRank</key><string>Alternate</string>
              </dict>
          </array>
      </dict>
      </plist>
    PLIST

    # Ad-hoc sign, same as a local `swift build`/Xcode run already does —
    # keeps AMFI/Gatekeeper happy about an unsigned binary. Since the app
    # is built locally rather than downloaded, macOS never quarantines it
    # in the first place, so this is belt-and-suspenders, not a
    # replacement for real notarization.
    system "codesign", "--force", "--deep", "--sign", "-", app

    prefix.install app
    system "ln", "-sf", app, "/Applications/Listo.app"
  end

  def caveats
    <<~EOS
      Listo.app was symlinked into /Applications so it shows up in
      Launchpad/Finder like a normal Mac app.

      Note for `brew uninstall`: it only removes files inside the
      Homebrew prefix, so the /Applications symlink is left behind
      (pointing at a now-missing app) — remove it yourself if needed:
        rm /Applications/Listo.app
    EOS
  end
end
