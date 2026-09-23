class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "1.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/1.14.0/theuth_1.14.0_macos-aarch64.tar.gz"
      sha256 "398a6f847ee51551d88545a266108f1e8a2f79391a7e9e828c21ade5160c5d89"
    end
  end
  on_linux do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/1.14.0/theuth_1.14.0_linux-aarch64.tar.gz"
      sha256 "4a7bd606b3ff5f222c45374ea2afb3e6efdf575428d0aa906049a0ac34d38a82"
    end
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/1.14.0/theuth_1.14.0_linux-x86_64.tar.gz"
      sha256 "fc3796750299e45dc753eb388ff65d93d71294bffeeeb6a7b8cb619ce1837618"
    end
  end

  def install
    bin.install "t"
    # Helpers `t` looks for next to its own resolved path: theuth-app-parser-<library hash>
    # (design doc 46 §2.1) and theuth-documents-<protocol version> (59 §3.2).
    bin.install Dir["theuth-app-parser-*"].fetch(0)
    bin.install Dir["theuth-documents-*"].fetch(0)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/t --version")
    helper = Dir[bin/"theuth-app-parser-*"].fetch(0)
    assert_match File.basename(helper).delete_prefix("theuth-app-parser-"), shell_output("#{helper} --version")
    docs = Dir[bin/"theuth-documents-*"].fetch(0)
    assert_match File.basename(docs).delete_prefix("theuth-documents-"), shell_output("#{docs} --version")
  end
end
