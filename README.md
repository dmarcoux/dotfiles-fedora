# Dotfiles for Fedora 41 KDE

## Live ISO / Installation

Set the keyboard layout with `localectl set-keymap ca-multix`. This is
important for the LUKS encryption passphrase and my user password. Otherwise,
they won't match once I boot in the installed system.

## Setup After Installation

1. Set hostname, and log out before logging back in for this to take effect.

   ```bash
   hostnamectl hostname <NAME>
   ```

2. Setup 1Password.

   1. Install 1Password GUI and CLI.

      _The 1Password Yum repository is automatically configured via the RPM
      file. It also installs the GUI. The CLI is then available to be installed
      from that repository._

      ```bash
      sudo rpm --install https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm &&
        sudo dnf install 1password-cli
      ```

   2. Add 1Password to autostart in KDE. Do not forget to add `--silent` to the
      arguments to start the GUI in the system tray.

   3. Enable [1Password SSH agent](https://developer.1password.com/docs/ssh/get-started/#step-3-turn-on-the-1password-ssh-agent).

   4. [Sign Git commits with my SSH key](https://developer.1password.com/docs/ssh/git-commit-signing/).

   5. Configure the GUI to match the settings stored in my 1Password notes.

3. Open Firefox and connect to Firefox Sync. This restores my extensions and
   settings. The linkding and 1Password extensions must be configured. See my 1Password notes
   for 1Password's extension settings.

4. Setup zsh.

   1. Install zsh and set it as the default shell.

      ```bash
      sudo dnf install zsh &&
        chsh -s $(which zsh)
      ```

   2. Reboot for this to take effect.

5. Setup [homebrew](https://brew.sh/) for CLI applications not available in Fedora's official repositories.

   1. Install dependencies for homebrew, then install it.

      ```bash
      sudo dnf install @development-tools &&
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ``` 

   2. Follow the _Next Steps_ displayed at the end of homebrew's installation.

6. Setup chezmoi with my dotfiles repository.

   ```bash
   brew install chezmoi &&
     chezmoi init git@github.com:dmarcoux/dotfiles-fedora.git
   ```

7. Install CLI applications from Brewfile.

   ```bash
   brew bundle --file $(dirname "$(chezmoi source-path)")/Brewfile
   ```

8. Setup and use [RPM Fusion](https://rpmfusion.org/RPM%20Fusion) for softwares not available in Fedora's official repositories

   1. [Verify RPM Fusion's signing keys](https://rpmfusion.org/keys).

   2. [Install RPM Fusion's free and non-free repositories](https://rpmfusion.org/Configuration).

   3. [Install codecs](https://rpmfusion.org/Howto/Multimedia).

9. Install [Mullvad VPN](https://mullvad.net/en/download/vpn/linux).
