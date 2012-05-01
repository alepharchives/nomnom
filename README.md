nomnom is a simple implementation of the DSAPI for SmartOS. It also comtains a simple tool to create new datasets.


to create datasets copy the tools folder somewhere on the SmartOS hypervisor (global zone) there you can run:

```
./create <zone UUID> <name> <version>
```

it will create the needed data under datasets/<dataset uuid>. You can modify datasets/<dataset uuid>/<dataset uuid>.dsmanifest to your liking.

you can copy that into the priv/datasets folder of nomnom and then reun the buildindex script there.


Ror creating datasets only KVM hosts are supported right now.