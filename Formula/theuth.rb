class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "1.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/1.15.0/theuth_1.15.0_macos-aarch64.tar.gz"
      sha256 "256f56e8f3df852214177df185536eb213d683118b132f3204e7092d147b0207"
    end
  end
  on_linux do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/1.15.0/theuth_1.15.0_linux-aarch64.tar.gz"
      sha256 "f332f59c57181e497effe5e5e5d77e1068bfbf3d16d2efd6088eb94bc9133c63"
    end
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/1.15.0/theuth_1.15.0_linux-x86_64.tar.gz"
      sha256 "4bf00cdb43b4539003f82bb53e56172445ec0ac355c8e6d8c97bca17f99802c3"
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
