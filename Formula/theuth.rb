class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.22.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.22.1/theuth_2.22.1_macos-aarch64.tar.gz"
      sha256 "6b47f19245fd7c30761b6ae18d0c96e36f91e950e376c04f1e721f6e5b1ddc71"
    end
  end
  on_linux do
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/2.22.1/theuth_2.22.1_linux-x86_64.tar.gz"
      sha256 "6fceff2c3f129ae72596b01ce097869067dbbe7a30df0f9dceb9add860a647a6"
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
