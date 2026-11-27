# Homebrew cask for the OpenDirectory Admin Center, published in the Lin8x/homebrew-tap repository.
# The OpenDirectory release workflow fills in the version and SHA-256 and pushes it here on every release
# (template: packaging/homebrew/Casks/opendirectory.rb.in in Lin8x/OpenDirectory).
cask "opendirectory" do
  version "0.12.0"
  sha256 "8e993e1a72d455f3bb2985d88701b016a483b5a41103bc505271c36e64ed14b4"

  url "https://github.com/Lin8x/OpenDirectory/releases/download/v#{version}/OpenDirectory.Admin.Center_#{version}_universal.dmg"
  name "OpenDirectory Admin Center"
  desc "Directory, Group Policy and endpoint management for every OS"
  homepage "https://github.com/Lin8x/OpenDirectory"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The Admin Center updates itself from GitHub Releases.
  auto_updates true

  app "OpenDirectory Admin Center.app"

  # The app isn't notarized by Apple yet, so macOS would refuse to open it. Installing it through this tap means you
  # chose to trust it, so the download's quarantine flag is removed. Each release lists SHA-256 checksums.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/OpenDirectory Admin Center.app"]
  end

  zap trash: [
    "~/Library/Application Support/dev.opendirectory.admincenter",
    "~/Library/Caches/dev.opendirectory.admincenter",
    "~/Library/Preferences/dev.opendirectory.admincenter.plist",
    "~/Library/WebKit/dev.opendirectory.admincenter",
  ]

  caveats <<~EOS
    OpenDirectory Admin Center isn't notarized by Apple yet. This cask removes macOS's quarantine flag from it so it opens.
  EOS
end
