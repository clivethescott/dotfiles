semanticdbVersion := "4.5.13"
Global / semanticdbEnabled := true
Global / onChangedBuildSource := ReloadOnSourceChanges

addCommandAlias("rerun", "scalafixAll; compile; docker:publishLocal; up dev")

