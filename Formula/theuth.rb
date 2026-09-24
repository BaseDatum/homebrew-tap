class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "1.17.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/1.17.0/theuth_1.17.0_macos-aarch64.tar.gz"
      sha256 "f0f433411f8bb9ab7b518255d8dfe78a7749d006bddf82ad98e0b3f831fe7058"
    end
  end
  on_linux do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/1.17.0/theuth_1.17.0_linux-aarch64.tar.gz"
      sha256 "4d47865a06851ba50d72ce0777962f2371fff780d92f0f88b5ac6d74701aa3da"
    end
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/1.17.0/theuth_1.17.0_linux-x86_64.tar.gz"
      sha256 "7c237a9a38a53a332c4a327dd20eb72c2a4bad4a6f470f622ade9198bf99cae1"
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
