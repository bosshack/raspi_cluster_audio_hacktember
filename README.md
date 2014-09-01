# Raspberry Pi Audio Cluster Hacktember

This is a project to manage a whole-home audio system using Raspberry Pis.  The
system will use PulseAudio to route the audio, and it will use an elixir process
to manage the pulseaudio configuration.  An android application will interact
with the elixir network via JInterface in order to modify the configuration of
the network, and each node will be responsible for migrating that configuration
down to its pulseaudio process.

Ideally, we'll have some form of automation for building the images that go on
the raspi SD Cards.  I currently love Ansible for this sort of thing.

## Trello

We're managing this project via Trello.  [The Trello board is
here](https://trello.com/b/HcNm5esh/boss-cluster)
