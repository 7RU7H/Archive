# Hardening

[ssh tarpit](https://github.com/skeeto/endlessh)


## Softblock wifi and bluetooth
```bash
rfkill list
rfkill block wifi
rkilll block bluetooth
```

To hardblock wifi or bluetooth find the toggle on motherboards, in bioses and other switchs on peripherals.   