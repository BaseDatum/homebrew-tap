class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.20.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.20.3/theuth_2.20.3_macos-aarch64.tar.gz"
      sha256 "b7f95dc4dd368b46e014faa50a29a7f4a0a7e48d8e3b84fd30e5f0e35e0156c4"
    end
  end
  on_linux do
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/2.20.3/theuth_2.20.3_linux-x86_64.tar.gz"
      sha256 "2f20cb021f7912149eb24c3da0c101727f0a3ffad836d9a9bbafb2b3adac294b"
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
