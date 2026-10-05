class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.7.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.7.0/theuth_2.7.0_macos-aarch64.tar.gz"
      sha256 "025ab491ffea5789fac80efde0483531adcd227346c1dd74bff157ce3391d844"
    end
  end
  on_linux do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.7.0/theuth_2.7.0_linux-aarch64.tar.gz"
      sha256 "db07186049f8663fb0c91831390bc39b8dcb8eadcc80b48ab48fe3b7acee08f5"
    end
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/2.7.0/theuth_2.7.0_linux-x86_64.tar.gz"
      sha256 "f1d168a117aa100f77411d43a283e7df857448ac68a4c677f140ad324f6951b4"
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
