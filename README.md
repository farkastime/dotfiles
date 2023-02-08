# Farkas Does Dotfiles

Here are the dotfiles I configured to sync settings across the machines I use at work and home. I took a lot of inspiration from other dotfiles repos found on [this page](https://dotfiles.github.io/), and am using [dotbot](https://github.com/anishathalye/dotbot) to automate deployment, which has worked very nicely. 

Because I currenly work both on MacOS locally, and Amazon Machine Images on AWS, I have separate `install.conf.[OS].yaml` files, `install.[OS]` scripts, and a handfull of dotfiles that are differentially configured, such as VS Code extension lists. 

The configuration of Homebrew installation with a Brewfile is WIP, but I have high hopes. 
