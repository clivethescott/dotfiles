// Global / semanticdbEnabled := true
semanticdbVersion := "4.6.0"
Global / onChangedBuildSource := ReloadOnSourceChanges

addCommandAlias("rerun", "scalafixAll; compile; docker:publishLocal; up dev")

