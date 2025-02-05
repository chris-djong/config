Add a flake to your git repo without commiting it using

```
  git add --intent-to-add flake.nix
  git update-index --assume-unchanged flake.nix
```

In case you want to undo this operation, you can do a

```
git update-index --no-assume-unchanged flake.nix
git rm --cached flake.nix
```
