class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.31.2"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.31.2/theuth_2.31.2_macos-aarch64.tar.gz"
      sha256 "cc5db2cd916c2aff9458d939665ba87f7e83963e036ad6c035b5ab10f136d426"
    end
  end
  on_linux do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.31.2/theuth_2.31.2_linux-aarch64.tar.gz"
      sha256 "38155eb77a7f133da90b1fbbeac88b90682b58588e43e6954619c9e221c844e0"
    end
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/2.31.2/theuth_2.31.2_linux-x86_64.tar.gz"
      sha256 "2ac6a61d5bc3a96ead28548a0f74bdd3a901573099ce278a7795b50f90c5a151"
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
