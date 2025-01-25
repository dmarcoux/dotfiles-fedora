# Dotfiles for Fedora 41

## Live ISO / Installation

In the *Live ISO*, set the keyboard layout to `Canadian (CSA)`:
- In the terminal with `localectl set-keymap ca-multix`
- In the OS settings (Search for `Keyboard`)

In the installation, the keyboard must also be set to `Canadian (CSA)`. Search
or find it under `French (Canada)`.

This is important for the LUKS encryption passphrase and my user password.
Otherwise, they won't match once I boot in the installed system.

## Setup After Installation

*chezmoi* automates the setup after the OS installation. To understand how this
works, it's important to understand *chezmoi*'s
[reference](https://www.chezmoi.io/reference/) with its source state attributes,
and application order. Those define when each configuration/script is
applied/executed. For example, the execution order of scripts is based on their
source state attributes, then their name.

1. On the first boot, the setup window appears. Be sure to enable the
   third-party repositories.

2. Set hostname, and log out before logging back in for this to take effect.

   ```bash
   hostnamectl hostname <NAME>
   ```

3. Update the system to have the latest packages.

   ```bash
   sudo dnf upgrade --refresh
   ```

4. Setup zsh.

   1. Install zsh and set it as the default shell.

      ```bash
      sudo dnf install zsh &&
        chsh -s $(which zsh)
      ```

   2. Reboot for this to take effect.

5. Setup 1Password GUI/CLI and Chromium

   1. Install 1Password GUI and CLI.

      _1Password instructions taken from its [official website](https://support.1password.com/install-linux/)._

      ```bash
      sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc &&
        sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo' &&
        sudo dnf install 1password 1password-cli
      ```

   2. Install Chromium.

      ```bash
      sudo dnf install chromium
      ```

   3. Enable [1Password SSH agent](https://developer.1password.com/docs/ssh/get-started/#step-3-turn-on-the-1password-ssh-agent).

   4. [Sign Git commits with my SSH key](https://developer.1password.com/docs/ssh/git-commit-signing/).

   5. Configure the 1Password GUI to match the settings stored in my 1Password notes.

6. Setup [homebrew](https://brew.sh/) for CLI applications not available in Fedora's official repositories.

   ```bash
   sudo dnf install @development-tools &&
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &&
     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
   ```

7. Setup chezmoi with my dotfiles repository.

   ```bash
   brew install chezmoi &&
     chezmoi init git@github.com:dmarcoux/dotfiles-fedora.git &&
     brew bundle --file $(dirname "$(chezmoi source-path)")/Brewfile &&
     chezmoi apply
   ```

8. Open Firefox and connect to Firefox Sync. This restores my extensions and
   settings. The linkding and 1Password extensions must be configured. See my 1Password notes
   for 1Password's extension settings.

9. Install Anytype.

   ```bash
   flatpak install io.anytype.anytype
   ```

10. Install [Mullvad VPN](https://mullvad.net/en/download/vpn/linux).

    ```bash
    sudo dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo &&
      sudo dnf install mullvad-vpn
    ```
