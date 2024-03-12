vim.filetype.add({
  filename = {
    ['Jenkinsfile'] = 'groovy',
    ['Jenkinsfile.deployment'] = 'groovy',
  },
  extension = {
    ['pp'] = 'json', -- Spinnaker pipeline
    ['conf'] = 'jproperties',
  }
})
