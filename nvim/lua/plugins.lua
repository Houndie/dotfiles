return require('packer').startup(function()
    -- manage itself
    use 'wbthomason/packer.nvim'

    -- manage language servers
    use 'williamboman/mason.nvim'    
    use 'williamboman/mason-lspconfig.nvim'
end)
