# Homebrew cask for FluidMessages Web on Mac, published in the Lin8x/homebrew-tap repository.
# scripts/update-homebrew-tap fills in the version and SHA-256 and pushes it there on every release.
cask "fluidmessages-web" do
  version "0.47.1"
  sha256 "a02a63fbea75f2b46e067ad5edb850788e686737a5cf1a248bb8b707f7ec4a57"

  url "https://github.com/Lin8x/FluidMessages/releases/download/v#{version}/FluidMessages-Web-#{version}-macOS.dmg"
  name "FluidMessages Web"
  desc "Your phone's texts, calls and chats on your computer"
  homepage "https://github.com/Lin8x/FluidMessages"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64

  app "FluidMessages Web.app"

  # The app isn't notarized by Apple yet, so macOS would refuse to open it. Installing it through this tap means you
  # chose to trust it, so the download's quarantine flag is removed. Check the download first if you like:
  # https://github.com/Lin8x/FluidMessages/blob/main/docs/verify.md
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/FluidMessages Web.app"]
  end

  zap trash: "~/Library/Application Support/FluidMessages Web"

  caveats <<~EOS
    FluidMessages Web isn't notarized by Apple yet. This cask removes macOS's quarantine flag from it so it opens.
    To see your texts, link your Android phone in FluidMessages Web: Settings → Phone and other devices.
  EOS
end
