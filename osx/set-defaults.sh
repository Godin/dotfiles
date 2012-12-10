#!/bin/sh
#
# Sets reasonable OS X defaults.
#
# Inspired by:
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx
#

# Finder: allow quitting via Cmd + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Prevent creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
