class Notify < Formula
  desc "Notify is a versatile command-line tool designed to streamline the process of sending notifications. It supports multiple notification methods, including audio alerts and dialog boxes, making it suitable for a wide range of use cases. Whether you need to deliver success messages, error alerts, or informational updates, Notify provides a customizable and efficient solution."
  homepage "https://github.com/sergiorivas/notify"
  url "https://github.com/sergiorivas/notify/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0791b8fc118e66142c13fe31cce82f8f0df4f7e6e251c3054d2244fb39280f4f"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    path = buildpath/"src/github.com/sergiorivas/notify"
    path.install Dir["*"]
    cd path do
      system "go", "build", "-o", bin/"notify", "./cmd/notify"
    end
  end
end
