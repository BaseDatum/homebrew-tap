class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.31.1"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.31.1/theuth_2.31.1_macos-aarch64.tar.gz"
      sha256 "dfd13f53db0e71b675ba72f92be915d82e3270dee8446f22daab8492257c9639"
    end
  end
  on_linux do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.31.1/theuth_2.31.1_linux-aarch64.tar.gz"
      sha256 "30b70ef0d902ec0aa0bcde3a05e85e742ef7244161e43fb4633ca9d6cbee54c2"
    end
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/2.31.1/theuth_2.31.1_linux-x86_64.tar.gz"
      sha256 "d3e67377b28d2c91620e2bf9d74309559b370e51235c86ee1a32529dcbeea35a"
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
