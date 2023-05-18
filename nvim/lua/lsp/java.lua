local M = {}
M.setup = function(on_attach)
  local ok, jdtls = pcall(require, 'jdtls')
  if not ok then
    return
  end


  local nvim_data_dir = vim.fn.stdpath('data')
  local jdtls_install_dir = nvim_data_dir .. '/mason/packages/jdtls/'
  -- eclipse.jdt.ls stores project specific data within the folder set via the -data flag.
  -- If you're using eclipse.jdt.ls with multiple different projects you must use a dedicated data directory per project.
  -- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  local workspace_dir = nvim_data_dir .. '/jdtls/projects/' .. project_name
  local lombok_path = nvim_data_dir .. '/jdtls/libs/lombok-1.18.26.jar'
  local capabilities = {
    workspace = {
      configuration = true
    },
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  }
  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
  local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

      -- 💀
      'java', -- or '/path/to/java11_or_newer/bin/java'
      -- depends on if `java` is in your $PATH env variable and if it points to the right version.

      '-javaagent:' .. lombok_path,
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=false',
      '-Dlog.level=WARN',
      '-Xmx2g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

      -- 💀
      '-jar', jdtls_install_dir .. 'plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
      -- Must point to the                                                     Change this to
      -- eclipse.jdt.ls installation                                           the actual version


      -- 💀
      '-configuration', jdtls_install_dir .. 'config_mac',
      -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
      -- Must point to the                      Change to one of `linux`, `win` or `mac`
      -- eclipse.jdt.ls installation            Depending on your system.


      -- 💀
      -- See `data directory configuration` section in the README
      '-data', workspace_dir
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({ 'pom.xml', 'mvnw', '.gradle', 'gradlew' }),

    flags = {
      -- debounce_text_changes = 80,
      allow_incremental_sync = true,
    },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
      ['java.format.settings.profile'] = "GoogleStyle",
      java = {
        inlayHints = {
          parameterNames = { enabled = true },
        },
        references = {
          includeAccessors = true,
          includeDecompiledSources = true,
        },
        referenceCodeLens = { enabled = true },
        signatureHelp = {
          enabled = true,
          description = { enabled = true },
        },
        contentProvider = { preferred = 'fernflower' }, -- Use fernflower to decompile library code
        implementationsCodeLens = { enabled = true },
        saveActions = { organizeImports = true },
        completion = {
          favoriteStaticMembers = {
            "org.mockito.BDDMockito.*",
            "org.assertj.core.api.Assertions.*",
            "java.util.Objects.requireNonNull",
          },
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*", "sun.*",
          },
          guessMethodArguments = true,
          overwrite = true,
        },
        configuration = {
          runtimes = {
            {
              name    = 'JavaSE-17',
              -- path    = vim.fn.system('cs java-home'),
              default = true
            },
          }
        },
        sources = {
          organizeImports = {
            starThreshold = 20,
            staticStarThreshold = 10,
          }
        },
        maven = {
          enabled = true,
          downloadSources = true,
        },
        format = {
          enabled = true,
          insertSpaces = true,
          tabSize = 2,
        },
        project = {
          resourceFilters = { ".git" }
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
          },
          useBlocks = true,
          generateComments = false,
          hashCodeEquals = {
            useJava7Objects = true,
            useInstanceof = true,
          }
        }
      }
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- For Debugging support, See:
    -- https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    -- https://sookocheff.com/post/vim/neovim-java-ide/
    --
    -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    init_options = {
      bundles = {},
      extendedClientCapabilities = extendedClientCapabilities,
    },
  }
  config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  end

  local jdtls_group = vim.api.nvim_create_augroup("jdtls-group", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java" },
    callback = function()
      -- This starts a new client & server,
      -- or attaches to an existing client & server depending on the `root_dir`.
      jdtls.start_or_attach(config)
    end,
    group = jdtls_group,
  })
end

return M
