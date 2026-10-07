class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.12.0/theuth_2.12.0_macos-aarch64.tar.gz"
      sha256 "fbfe17169d0af40f31eacb98eab32ea0810e702ca4d01a5a4a414e6d9f92cddb"
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
