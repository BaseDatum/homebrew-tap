class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.20.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.20.2/theuth_2.20.2_macos-aarch64.tar.gz"
      sha256 "45e9f3818e49a2c5bca627f9fe7c6d2aafb83d0f105795b07fc9f9a867d2975e"
    end
  end
  on_linux do
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/2.20.2/theuth_2.20.2_linux-x86_64.tar.gz"
      sha256 "1380fafa34748cbf0512f4ca9e3630616bceca62c81e576f762e08c66f4a3687"
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
