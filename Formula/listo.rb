class Listo < Formula
  desc "To-do list that lives as plain Markdown on disk"
  homepage "https://github.com/sergiorivas/listo"
  url "https://github.com/sergiorivas/listo/releases/download/v0.1.1/Listo-0.1.1.zip"
  sha256 "a9546973d8b22d87f0bd29eca1616c3d7bb2623cc8985217a90970d5bb0ac718"
  version "0.1.1"

  def install
    # Homebrew already unpacked the zip into the working directory, so
    # Listo.app is right here. Strip the quarantine flag the download
    # picked up — the app is only ad-hoc signed, not notarized, so
    # Gatekeeper would otherwise refuse to open it.
    system "xattr", "-cr", "."
    prefix.install "Listo.app"
    system "ln", "-sf", prefix/"Listo.app", "/Applications/Listo.app"
  end

  def caveats
    <<~EOS
      Listo.app was symlinked into /Applications so it shows up in
      Launchpad/Finder like a normal Mac app.

      This build is ad-hoc signed, not notarized by Apple. If macOS still
      refuses to open it, run:
        xattr -cr /Applications/Listo.app

      Note for `brew uninstall`: it only removes files inside the
      Homebrew prefix, so the /Applications symlink is left behind
      (pointing at a now-missing app) — remove it yourself if needed:
        rm /Applications/Listo.app
    EOS
  end
end
