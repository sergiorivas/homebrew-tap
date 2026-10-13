cask "psr-banks" do
  version "0.3.7"
  sha256 "20f3c50132250b6f8f9d7dbac8a7ff90bc926ef99be7d12a7f45282391bad0e5"

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
