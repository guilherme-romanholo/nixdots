{
  name,
  groups,
  shell,
  authKeys ? [],
  config
}: {
  inherit name groups shell authKeys;

  hm = {

  } // config;
}
