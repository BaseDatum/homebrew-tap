cask "theuth" do
  version "2.29.0"
  sha256 "c82bc642aed7ee13dfe3d86cf99c864f84dde2060bd3f8caf874645f53a2489e"

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
