cask "taffy" do
  version "0.0.1"
  sha256 "f3182dc7527e906be4343a1b9235b48c8b2bfc9da224d0bc5665323d4f8dab6f"

  url "https://github.com/yteraoka/taffy/releases/download/v#{version}/Taffy-#{version}-macos-universal.zip"
  name "Taffy"
  desc "Search tabs across browsers and switch to them"
  homepage "https://github.com/yteraoka/taffy"

  livecheck do
    skip "Auto-generated on release."
  end

  depends_on macos: ">= :ventura"

  app "Taffy.app"

  # ad-hoc 署名で公証していないため、quarantine 属性を外して Gatekeeper に止められないようにする
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Taffy.app"]
  end

  uninstall quit: "com.github.yteraoka.taffy"

  zap trash: "~/Library/Preferences/com.github.yteraoka.taffy.plist"

  caveats <<~EOS
    Taffy runs in the menu bar. Press Shift-Command-Space to search tabs.
    The first time it reads tabs, macOS asks to allow Taffy to control each browser.
  EOS
end
