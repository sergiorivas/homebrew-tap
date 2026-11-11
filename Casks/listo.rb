cask "listo" do
  version "0.1.52"
  sha256 "6ead802e54880c57a68e45575ed3c5e239077771940104049085cecdf86f7281"

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
