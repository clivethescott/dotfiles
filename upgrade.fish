#!/usr/bin/env fish

brew upgrade
if type -q mise
  mise upgrade
else
  echo 'mise is not installed....skipping update'
end
if type -q rustup
  rustup update
else
  echo 'rustup is not installed....skipping update'
end
if type -q devx
  devx update
else
  echo 'devx is not installed....skipping update'
end
if type -q nvim
  echo "Open nvim and run :Lazy sync, :Mason update"
end
