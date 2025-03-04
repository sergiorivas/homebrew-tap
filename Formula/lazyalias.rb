class Lazyalias < Formula
  desc "LazyAlias is a command-line tool that helps you manage and execute frequently used commands across different projects. It provides an interactive menu to select commands defined in a YAML configuration file and copies them to your clipboard for easy execution."
  homepage "https://github.com/sergiorivas/lazyalias"
  url "https://github.com/sergiorivas/lazyalias/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "bac0bcdf0d4ad2c8e98b4acf1faff4d380956c6465df50bed813ffc858447196"

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
