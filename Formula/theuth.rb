class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.32.3"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.32.3/theuth_2.32.3_macos-aarch64.tar.gz"
      sha256 "f67fdc83861aaed00d513c8c7e22d7237f3560c842e16c0a5fc3d3666e4e2e43"
    end
  end
  on_linux do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.32.3/theuth_2.32.3_linux-aarch64.tar.gz"
      sha256 "40cc1a11d4daf113f0f106ca14c7363ca31bef7d1b80fb66789f22552edce16a"
    end
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/2.32.3/theuth_2.32.3_linux-x86_64.tar.gz"
      sha256 "39b205f36d19686abc3d0454747040c4ed69e61532f6c7422e8548b47aefec60"
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
