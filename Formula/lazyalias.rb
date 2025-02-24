class Lazyalias < Formula
  desc "LazyAlias is a command-line tool that helps you manage and execute frequently used commands across different projects. It provides an interactive menu to select commands defined in a YAML configuration file and copies them to your clipboard for easy execution."
  homepage "https://github.com/sergiorivas/lazyalias"
  url "https://github.com/sergiorivas/lazyalias/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "2f3ffeeb4ae287e6daf426460effe92227e8d22b5ec8ae650746e70751585d07"

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
