-- iD/aD etc within word
-- https://github.com/machakann/vim-textobj-delimited


return {
  "machakann/vim-textobj-delimited",

  keys = {
    {"id", "<Plug>(textobj-delimited-forward-i)", mode={"x", "o"}},
    {"ad", "<Plug>(textobj-delimited-forward-a)", mode={"x", "o"}},
    {"iD", "<Plug>(textobj-delimited-backward-i)", mode={"x", "o"}},
    {"aD", "<Plug>(textobj-delimited-backward-a)", mode={"x", "o"}},
  }
}
