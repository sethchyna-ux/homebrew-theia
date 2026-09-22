cask "theia" do
  version "0.1.0"

  # After each release, update url and run:
  #   shasum -a 256 theia_VERSION_aarch64.dmg   (Apple Silicon)
  #   shasum -a 256 theia_VERSION_x64.dmg        (Intel)
  on_arm do
    url "https://github.com/sethchyna-ux/theia/releases/download/v#{version}/theia_#{version}_aarch64.dmg"
    sha256 "196b0312e6cbd03e0696ebcc0021288a26bf30ce45d514fcdddd1a753bd22aaf"
  end
  on_intel do
    url "https://github.com/sethchyna-ux/theia/releases/download/v#{version}/theia_#{version}_x64.dmg"
    sha256 "REPLACE_WITH_SHASUM_OF_X64_DMG"
  end

  name "Theia"
  desc "Blazingly fast, open-source SSH client and terminal — zero subscriptions, zero paywalls"
  homepage "https://github.com/sethchyna-ux/theia"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "theia.app"

  # Remove quarantine attribute so Gatekeeper doesn't block unsigned builds
  postflight_steps do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/theia.app"],
                   sudo: false
  end

  uninstall quit: "com.theia.ssh"
  zap trash: [
    "~/Library/Application Support/com.theia.ssh",
    "~/Library/Preferences/com.theia.ssh.plist",
    "~/Library/Caches/com.theia.ssh",
    "~/Library/Logs/theia",
    "~/.config/theia",
  ]

  caveats <<~EAS
    Theia is free and open-source — no subscriptions, no paywalls.
    Anti-Freemium. Built for power users.

    If macOS blocks the app on first launch (unsigned build), run:
      xattr -dr com.apple.quarantine /Applications/theia.app
    Or open System Settings → Privacy & Security → Open Anyway.
  EAS
end
