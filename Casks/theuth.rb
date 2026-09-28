cask "theuth" do
  version "2.1.1"
  sha256 "2fea57874679301fd18c2d5e096d133171a445556bfb4843c6a4aea1c0a64f66"

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
