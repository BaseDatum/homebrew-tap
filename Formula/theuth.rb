class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "1.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/1.16.0/theuth_1.16.0_macos-aarch64.tar.gz"
      sha256 "f06c84b93588d20abfb308f5d3f7a7a7298a6e7521243a5ae85679938868155f"
    end
  end
  on_linux do
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/1.16.0/theuth_1.16.0_linux-x86_64.tar.gz"
      sha256 "a82bced9d32f90db06e2f507990ad08a7c994ef39449dbebd470f3789ecc4c74"
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
