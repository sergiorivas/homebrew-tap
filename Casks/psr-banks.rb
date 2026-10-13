cask "psr-banks" do
  version "0.3.3"
  sha256 "4a1ee5f3e88db0dc42fbdd5827e8ddf8b136ae411824ff659ab0a5e043c9f075"

  url "https://github.com/sergiorivas/psr-banks/releases/download/v#{version}/PSRBanks-#{version}.zip"
  name "PSR Banks"
  desc "Library and setlist manager for Yamaha PSR-E483 registration memory files"
  homepage "https://github.com/sergiorivas/psr-banks"

  depends_on macos: :sonoma

  app "PSR Banks.app"

  postflight_steps do
    # Ad-hoc signed, not notarized: strip the download's quarantine flag.
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/PSR Banks.app"]
  end

  caveats do
    <<~EOS
      This build is ad-hoc signed, not notarized by Apple. If macOS still
      refuses to open it, run:
        xattr -cr "#{appdir}/PSR Banks.app"
    EOS
  end
end
