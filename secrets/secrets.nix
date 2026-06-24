let
  # ~/.ssh/id_ed25519.pub — lets tscolari re-edit secrets from any machine.
  tscolari = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMK39NokucOcYWseeGuQBJO/TXk9ouqp9fo8Bzg0iRUm tscolari@nixos";

  # Per-host age identities, generated via `age-keygen -o /var/lib/agenix/key.txt`
  # on each machine and captured with `age-keygen -y /var/lib/agenix/key.txt`.
  bebop = "age1pe9zcjgvc0xd69m3xu7tf4429087paxk9m7j3j7hsmludk06f3ds8lrg5p";
  happy = "age1ge4qu8u2ted34yak9yhevha74q6urtwhftpeksggjx9gd7z3qevs8a0nx9";
  cowboy = "age1yd8vzmpaapnsry7t2c8k427eqjg457ygurvkc5rq4pmns0nv954s8zdnfq";

  allHosts = [
    bebop
    happy
    cowboy
  ];
in
{
  "access-tokens.age".publicKeys = allHosts ++ [ tscolari ];
}
