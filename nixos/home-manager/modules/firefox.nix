{user, ...}: {
programs.firefox = {
    enable = true;
    profiles."${user}" = {
      extensions = with firefox-addons; [
        ublock-origin
	bitwarden
      ];
    };
  };
}

