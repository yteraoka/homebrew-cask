cask "taffy" do
  version "0.2.1"
  sha256 "8317af0da9478050c936605b2c7fac390fc4231f80f41e5fc81df5f7aa3bcc2e"

  url "https://github.com/yteraoka/taffy/releases/download/v#{version}/Taffy-#{version}-macos-universal.zip"
  name "Taffy"
  desc "Search tabs across browsers and switch to them"
  homepage "https://github.com/yteraoka/taffy"

  livecheck do
    skip "Auto-generated on release."
  end

  depends_on macos: :ventura

  app "Taffy.app"

  # ad-hoc 署名で公証していないため、quarantine 属性を外して Gatekeeper に止められないようにする
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Taffy.app"],
        must_succeed: false
  end

  uninstall quit: "com.github.yteraoka.taffy"

  zap trash: "~/Library/Preferences/com.github.yteraoka.taffy.plist"

  caveats <<~EOS
    Taffy runs in the menu bar. Press Shift-Command-Space to search tabs.
    The first time it reads tabs, macOS asks to allow Taffy to control each browser.
  EOS
end
