cask "psr-banks" do
  version "0.3.10"
  sha256 "2d969b20a28e8d827f8303a781f6990725c93da0b5e5436391bbee6b3ad3548c"

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
