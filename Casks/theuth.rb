cask "theuth" do
  version "1.13.2"
  sha256 "78437e1c79d0b70d726a78b111d7b5c0875ff171200953d57b1954cdbbf3dc07"

  url "https://s3.rwx.dev/theuth/releases/#{version}/theuth_#{version}_macos-aarch64.dmg"
  name "theuth"
  desc "Desktop app for the theuth harness"
  homepage "https://theuth.io/"

  livecheck do
    url "https://s3.rwx.dev/theuth/releases/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "theuth.app"

  zap trash: "~/Library/Application Support/io.theuth.mac"
end
