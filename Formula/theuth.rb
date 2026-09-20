class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://github.com/skymoore/theuth"
  version "1.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/1.7.0/theuth_1.7.0_macos-aarch64.tar.gz"
      sha256 "26212a6f224e453f3535e0ae9c8cd659dbaf96726719de7452db2cf37ff72696"
    end
  end

  def install
    bin.install "t"
    # App parser helper (design doc 46 §2.1): `t` looks for
    # theuth-app-parser-<library hash> next to its own resolved path.
    bin.install Dir["theuth-app-parser-*"].fetch(0)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/t --version")
    helper = Dir[bin/"theuth-app-parser-*"].fetch(0)
    assert_match File.basename(helper).delete_prefix("theuth-app-parser-"), shell_output("#{helper} --version")
  end
end
