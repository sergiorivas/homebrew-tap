cask "listo" do
  version "0.1.46"
  sha256 "221374a9ab0d56e8a67b01854aa4d4c007a10b388e4135f833d5342aefed59f5"

  url "https://github.com/sergiorivas/listo/releases/download/v#{version}/Listo-#{version}.zip"
  name "Listo"
  desc "To-do list that lives as plain Markdown on disk"
  homepage "https://github.com/sergiorivas/listo"

  app "Listo.app"

  postflight_steps do
    # This build is ad-hoc signed, not notarized by Apple (that needs a
    # paid Developer ID account) — macOS would otherwise refuse to open
    # it because of the Gatekeeper quarantine flag the download picked
    # up. `postflight_steps`/`run`, not the free-form `postflight`
    # block: the latter is deprecated by Homebrew in favor of this
    # declarative form.
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Listo.app"]
  end

  caveats do
    <<~EOS
      This build is ad-hoc signed, not notarized by Apple. If macOS still
      refuses to open it, run:
        xattr -cr #{appdir}/Listo.app
    EOS
  end
end
