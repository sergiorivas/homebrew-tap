class Lazyalias < Formula
  desc "LazyAlias is a command-line tool that helps you manage and execute frequently used commands across different projects. It provides an interactive menu to select commands defined in a YAML configuration file and copies them to your clipboard for easy execution."
  homepage "https://github.com/sergiorivas/lazyalias"
  url "https://github.com/sergiorivas/lazyalias/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "661748f96b4f612b923ff17ade92e3ab1de3634f125b15ad8a9a32e07fd0e57c"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    path = buildpath/"src/github.com/sergiorivas/lazyalias"
    path.install Dir["*"]
    cd path do
      system "go", "build", "-o", bin/"lazyalias", "./cmd/lazyalias"
    end
  end
end
