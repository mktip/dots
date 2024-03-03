{
  params,
  pkgs,
  ...
}: {
  time.timeZone = params.timeZone;
  i18n.defaultLocale = "en_US.UTF-8";

  users.users = {
    ${params.username} = {
      description = params.fullname;
      initialPassword = "123";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [];
      extraGroups = ["wheel" params.username];
    };
  };
}
