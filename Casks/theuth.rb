cask "theuth" do
  version "1.7.0"
  sha256 "e43db0259e5fafe3d3b9b7751e9ae52166a7bcd97146094bcabce77eeb9f9fcc"
  url "https://s3.rwx.dev/theuth/releases/#{version}/theuth_#{version}_macos-aarch64.dmg"
  name "theuth"
  desc "Desktop app for the theuth harness"
  homepage "https://github.com/skymoore/theuth"
  depends_on arch: :arm64
  depends_on macos: ">= :monterey"
  auto_updates true
  app "theuth.app"
  zap trash: "~/Library/Application Support/io.theuth.mac"
end
