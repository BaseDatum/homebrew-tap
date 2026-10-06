class Theuth < Formula
  desc "Harness that does things for the user"
  homepage "https://theuth.io/"
  version "2.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.9.0/theuth_2.9.0_macos-aarch64.tar.gz"
      sha256 "116c563e48bc9f72c0411cb09826f38769acf008acd18298849b7f9e3eb8a59a"
    end
  end
  on_linux do
    on_arm do
      url "https://s3.rwx.dev/theuth/releases/2.9.0/theuth_2.9.0_linux-aarch64.tar.gz"
      sha256 "df8f15a3bb41900fe7f094176e5da93b7f3ad003a353fc3b4a7dc7253b964c42"
    end
    on_intel do
      url "https://s3.rwx.dev/theuth/releases/2.9.0/theuth_2.9.0_linux-x86_64.tar.gz"
      sha256 "fec29ed9f9a442a3d33704f3afd0e3db3e6ed1b058a9cb77c88bf468ba556093"
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
