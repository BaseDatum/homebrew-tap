cask "theuth" do
  version "1.16.0"
  sha256 "006383be5b86ce126cfbe4c4e33b1a8a1f0d68af291b2b374339849413b153ec"

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
