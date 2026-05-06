class Parcelcli < Formula
  desc "Track parcels from the terminal with stable JSON output"
  homepage "https://github.com/cavit99/parcelcli"
  url "https://github.com/cavit99/parcelcli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "8b1cfb876ef75f86a5da1dc9c5849b1e4ee07fa2f386776dcae2ed3bdb16489d"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}"), "./cmd/parcelcli"
  end

  def caveats
    <<~EOS
      parcelcli's carrier adapters use headless Chrome/CDP. Install Google Chrome
      separately if it is not already available on this machine.
    EOS
  end

  test do
    assert_match "parcelcli version #{version}", shell_output("#{bin}/parcelcli --version")
    output = shell_output("#{bin}/parcelcli doctor --json")
    assert_match '"ready": true', output
  end
end
