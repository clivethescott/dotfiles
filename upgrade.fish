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
if type -q cargo-install-update
  cargo install-update -a
else
  echo 'cargo-update is not installed....skipping update'
end
if type -q node
  npm update -g
else
  echo 'node is not installed....skipping update'
end
if type -q uv
  uv tool upgrade --all
else
  echo 'uv is not installed....skipping update'
end
if type -q devx
  devx update
else
  echo 'devx is not installed....skipping update'
end
if type -q nvim
  echo "Open nvim and run :Lazy sync, :Mason update"
end
