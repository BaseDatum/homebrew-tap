class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.31.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.31.1/theuth_2.31.1_macos-aarch64.tar.gz"
      sha256 "dfd13f53db0e71b675ba72f92be915d82e3270dee8446f22daab8492257c9639"
    end
  end

  def install
    bin.install "t"
    # The helper `t` looks for next to its own resolved path: theuth-app-parser-<library hash>
    # (design doc 46 §2.1). The documents helper is compiled into `t`.
    bin.install Dir["theuth-app-parser-*"].fetch(0)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/t --version")
    helper = Dir[bin/"theuth-app-parser-*"].fetch(0)
    assert_match File.basename(helper).delete_prefix("theuth-app-parser-"), shell_output("#{helper} --version")
  end
end
