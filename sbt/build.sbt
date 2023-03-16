Global / semanticdbEnabled := true
Global / onChangedBuildSource := ReloadOnSourceChanges
semanticdbVersion := "4.6.0"
 
// Global / logLevel := Level.Debug

addCommandAlias("ci", ";clean; compile;test; assembly;")
