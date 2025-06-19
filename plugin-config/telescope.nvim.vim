" https://github.com/nvim-telescope/telescope.nvim

" wiki.vim ---------------------------------------------------------------{{{1

lua << EOF
vim.g.wiki_select_method = {
    pages = require("wiki.telescope").pages,
    tags = require("wiki.telescope").tags,
    toc = require("wiki.telescope").toc,
    links = require("wiki.telescope").links,
}
EOF
