cask "theuth" do
  version "2.28.1"
  sha256 "f2640d38326700a32699a720cba32d9743e27ccfcd442008de517f59a193bd49"

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
