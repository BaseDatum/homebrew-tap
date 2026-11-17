class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.22.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.22.0/theuth_2.22.0_macos-aarch64.tar.gz"
      sha256 "4d12a2347a0e91ce404ecaf9e7d680a268c9bde512554fa5966b4fee11830100"
    end
  end
  on_linux do
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/2.22.0/theuth_2.22.0_linux-x86_64.tar.gz"
      sha256 "034270a147ea22fe065e806d06306df34a6076b02961c4d590e05e4c30f89d80"
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
